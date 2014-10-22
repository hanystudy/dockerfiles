dockerfile: pmtools
================
Build all your favourite project management tools in one box.

Inspired by [nickstenning/mediawiki](https://registry.hub.docker.com/u/nickstenning/mediawiki/) and [ikatson/reviewboard](https://registry.hub.docker.com/u/ikatson/reviewboard/).

Another mysql node still needed, like [official image](https://registry.hub.docker.com/_/mysql/). We also have an improved one [hanystudy/mysql](https://registry.hub.docker.com/u/hanystudy/mysql/) which can work with this image very smoothly. Here is our example:

	docker pull hanystudy/mysql:5.7.5 
	docker run --name mysql -p 3306:3306 \
		-e MYSQL_ROOT_PASSWORD=rootpassword \
		-e MYSQL_DATABASE=reviewboard \
		-d hanystudy/mysql:5.7.5

You can also find a better demo in **docker-run.sh**, **it's quite simple and clear, please read it carefully before you want to build new image or run a container**.  
	
This image includes following opensource tools installed:

Base Image
--------------

centos 7.0

Basic
--------------

supervisor
nginx
memcached
Development Tools

Project wiki
--------------

mediawiki
php-fpm
php-mysql
php-cli
php-xml

Code Review
---------------

reviewboard
python-setuptools
python-devel
python-psycopg2
python-pip
python-memcached
uwsgi

Total size
------------

1.347GB
