dockerfile: mysql
=================

This repo is inspired by [official mysql image](https://registry.hub.docker.com/_/mysql/).

Sometimes we need more than one databases to be created after database system initialized, and grant all the permission of those new databases to db user. Here is our example:

	sudo docker run --name mysql -p 3306:3306 \
	                -e MYSQL_ROOT_PASSWORD=mysqlrootpassword -e MYSQL_USER=admin -e MYSQL_PASSWORD=admin \
	                -e MYSQL_DATABASE=database_a:database_b -d hanystudy/mysql:5.7.5 

By default, the maximum number of new created database is unlimited, separated with colon ":".
