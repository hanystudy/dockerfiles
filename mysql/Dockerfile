FROM mysql:5.7.5

MAINTAINER Han Yi(hanystudy@gmail.com)

ADD ./data.sql /data.sql

CMD ['mysql', '< /data.sql', '--host=localhost', '--user=$DB_USER', '--password=$DB_PASS']
