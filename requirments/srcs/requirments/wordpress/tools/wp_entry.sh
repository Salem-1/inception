#!/bin/bash
# chmod 777 /var/www/html/wordpress
# chmod 777 /var/www/html/wordpress/*
cp wp-config.php /var/www/html/.
sed -i "s|worongdbname|$MYSQL_DATABASE|g" \
      /var/www/html/wp-config.php 
sed -i "s|wronguser|$MYSQL_USER|g" \
      /var/www/html/wp-config.php 
sed -i "s|wrongpassword|$MYSQL_PASSWORD|g" \
      /var/www/html/wp-config.php 
mv /var/www/html/wordpress/* /var/www/html/.

# cp -r /var/www/html/wordpress/* /var/www/html/.
# wp --allow-root core download --path=/var/www/html/wordpress
# sleep infinity
mkdir /run/php
cd /var/www/html
wp --allow-root --path=/var/www/html core install --url=$DOMAIN --title="$TITLE" \
	--admin_user=$ADMIN --admin_password=$ADMIN_PASSWORD --admin_email=$WP_EMAIL
wp --allow-root --path=/var/www/html option update blogname "$TITLE"
wp --allow-root --path=/var/www/html option update blogdescription "$DESCRIPTION"
wp --allow-root --path=/var/www/html option update blog_public 0
# sleep infinity
# set title 
# useranem 
# password 
# your email 
# search engine visibility 
# install wordpress 
# login username and password with remember me
# go to the main page not the dashboard
php-fpm7.3 -F



