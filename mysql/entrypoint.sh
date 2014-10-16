#!/bin/bash
set -e

if [ -z "$(ls -A /var/lib/mysql)" -a "${1%_safe}" = 'mysqld' ]; then
        if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
                echo >&2 'error: database is uninitialized and MYSQL_ROOT_PASSWORD not set'
                echo >&2 '  Did you forget to add -e MYSQL_ROOT_PASSWORD=... ?'
                exit 1
        fi

        mysql_install_db --user=mysql --datadir=/var/lib/mysql

        # These statements _must_ be on individual lines, and _must_ end with
        # semicolons (no line breaks or comments are permitted).
        # TODO proper SQL escaping on ALL the things D:
        TEMP_FILE='/tmp/mysql-first-time.sql'
        cat > "$TEMP_FILE" <<-EOSQL
                DELETE FROM mysql.user ;
                CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
                GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
                DROP DATABASE IF EXISTS test ;
        EOSQL

        IFS=":"

        if [ "$MYSQL_DATABASE" ]; then
                for database in $MYSQL_DATABASE; do
                        echo "CREATE DATABASE IF NOT EXISTS $database;" >> "$TEMP_FILE"
                done
        fi

        if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
                echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> "$TEMP_FILE"
                if [ "$MYSQL_DATABASE" ]; then
                        for database in $MYSQL_DATABASE; do
                                echo "GRANT ALL ON $database.* TO '$MYSQL_USER'@'%' ;" >> "$TEMP_FILE"
                        done
                fi
        fi

        echo 'FLUSH PRIVILEGES ;' >> "$TEMP_FILE"

        set -- "$@" --init-file="$TEMP_FILE"
fi
chown -R mysql:mysql /var/lib/mysql
exec "$@"