#!/bin/sh 

reviewboard-start

exec /usr/bin/supervisord -n -c /etc/supervisord.conf
