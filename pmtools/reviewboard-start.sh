#!/bin/sh
set -eu

DOMAIN="${RB_DOMAIN:-*}"

DB_HOST="${DB_HOST:-localhost}"
DB_USER="${DB_USER:-root}"
DB_PASS="${DB_PASS:-}"
RB_DB_NAME="${RB_DB_NAME:-}"

MEMCACHED="${MEMCACHED:-localhost:11211}"

ADMIN_USER="${ADMIN_USER:-admin}"
ADMIN_PASS="${ADMIN_PASS:-admin}"
ADMIN_EMAIL="${ADMIN_EMAIL:-admin@example.com}"

mkdir -p /var/www/

if [[ ! -d /var/www/reviewboard ]]; then
    rb-site install --noinput \
        --domain-name="$DOMAIN" \
        --site-root=/ --static-url=static/ --media-url=media/ \
        --db-type=mysql \
        --db-name="$RB_DB_NAME" \
        --db-host="$DB_HOST" \
        --db-user="$DB_USER" \
        --db-pass="$DB_PASS" \
        --cache-type=memcached --cache-info="$MEMCACHED" \
        --web-server-type=lighttpd \
        --admin-user="$ADMIN_USER" --admin-password="$ADMIN_PASS" --admin-email="$ADMIN_EMAIL" \
        /var/www/reviewboard/
fi