#!/bin/sh

# Maintainer Han Yi

DB_USER="pmtadmin"
DB_PASS="pmtadminpassword"
DB_ROOT_PASS="mysecretpassword"
RB_DB_NAME="reviewboard"

DB_HOST="mysql"

#Mysql container is still needed, we recommend you to use script below 
#Don't just uncomment these lines and run the whole shell, you should run two build separately 
#Otherwise reviewboard installation may fail for asynchronous issue
#docker pull hanystudy/mysql:5.7.5		
#docker run --name $DB_HOST -p 3306:3306 	\
#            -e MYSQL_ROOT_PASSWORD=$DB_ROOT_PASS -e MYSQL_USER=$DB_USER -e MYSQL_PASSWORD=$DB_PASS \
#            -e MYSQL_DATABASE=$RB_DB_NAME -d hanystudy/mysql:5.7.5 

docker build -t pmt-deploy .
docker run --name pmt --link mysql:mysql 	\
						   -p 80:80 			\
						   -p 8080:8080 		\
						   -v /data:/data 		\
						   -e DB_HOST=mysql 	\
						   -e DB_USER=$DB_USER 	\
						   -e DB_PASS=$DB_PASS 	\
						   -e RB_DB_NAME=$RB_DB_NAME	\
						   -e ADMIN_USER=admin 	\
						   -e ADMIN_PASS=admin 	\
						   -e ADMIN_EMAIL=admin@example.com	\
						   -d pmt-deploy 		
