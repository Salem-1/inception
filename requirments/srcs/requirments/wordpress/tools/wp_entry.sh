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
# sleep infinity
php-fpm7.3 -F