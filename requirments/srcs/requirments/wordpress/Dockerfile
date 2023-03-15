FROM debian:buster


ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_PASSWORD
ARG MYSQL_USER
ARG MYSQL_DATABASE
ARG WP_USER
ARG WP_PASSWORD
ARG WP_EMAIL
ARG DESCRIPTION
ARG TITLE
ARG DOMAIN

RUN mkdir -p /var/wordpress
RUN apt-get update -y
RUN apt-get install -y wget
RUN apt install curl -y

#php version is 7.3
EXPOSE 9000
RUN mkdir -p /var/www/html
RUN apt-get  install php-fpm php-mysql php-xml php-gd php-curl php-mbstring php-zip  -y
VOLUME /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar && php wp-cli.phar --info \
	&& cp wp-cli.phar /usr/local/bin/wp
RUN wget https://wordpress.org/latest.tar.gz 
RUN  tar -zxvf latest.tar.gz -C /var/www/html/. && rm -rf latest.tar.gz
COPY tools/wp-config.php .
COPY tools/wp_entry.sh .
COPY tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY tools/wp-config.php .
CMD ["./wp_entry.sh"]

#  sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
#       /etc/php8/php-fpm.d/www.conf && \
#you will give access to mariadb using wp command
#in Maria import the wbdatabase to your contianer 
