FROM centos:centos7

MAINTAINER Han Yi

# Install basic applications
RUN yum -y update
RUN yum install -y epel-release # mainly for reviewboard installation
RUN yum install -y supervisor 

# Install nginx
RUN yum install -y nginx

# Install memcached
RUN yum install -y memcached

# Install php environment
RUN yum install -y php-fpm php-mysql php-cli php-xml

# Install python environment
RUN yum groupinstall -y "Development Tools" # Only for uwsgi
RUN yum install -y python-setuptools python-devel python-psycopg2 python-pip
RUN yum install -y mysql-devel
RUN pip install -U python-memcached
RUN pip install mysql-python
RUN pip install -U uwsgi

# Install git
RUN yum install -y git-core

# Install reviewboard
RUN easy_install ReviewBoard

# Add system service config
ADD ./supervisord.conf /etc/supervisord.conf 
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./php-fpm.conf /etc/php-fpm.conf 
ADD ./www.conf /etc/php-fpm.d/www.conf
ADD ./uwsgi.ini /uwsgi.ini

# Config php environment
RUN mkdir -p /var/lib/php/session
RUN chmod -R 777 /var/lib/php/session

# Install mediawiki
RUN mkdir /src
ADD http://download.wikimedia.org/mediawiki/1.21/mediawiki-1.21.2.tar.gz /src/mediawiki.tgz
RUN cd /src && tar zxf mediawiki.tgz
RUN ln -snf /src/mediawiki-1.21.2 /src/mediawiki
RUN chown -R apache:apache /src/mediawiki/

# Config wiki data directory and symlinks that can then be used as a data volume
RUN mkdir -p /data/wiki/images
RUN ln -s /data/wiki/LocalSettings.php /src/mediawiki/LocalSettings.php
RUN rm -rf /src/mediawiki/images
RUN ln -s /data/wiki/images /src/mediawiki/images
RUN chown -R apache:apache /data/wiki

# Config reviewboard site
ADD ./reviewboard-nginx.conf /reviewboard-nginx.conf
RUN mkdir -p /etc/nginx/sites-enabled/
RUN ln -s /reviewboard-nginx.conf /etc/nginx/sites-enabled/

# Add startup script
ADD ./reviewboard-start.sh /usr/bin/reviewboard-start
ADD ./start.sh /usr/bin/pmt-start
RUN chmod +x /usr/bin/reviewboard-start /usr/bin/pmt-start

# 80 for wiki and 8080 for reviewboard
EXPOSE 80
EXPOSE 8080

CMD ["/usr/bin/pmt-start"]
