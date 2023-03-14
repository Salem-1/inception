#!/bin/bash
mv /var/www/html/wordpress/* /var/www/html/.
cp wp-config.php /var/www/html/.
# cp -r /var/www/html/wordpress/* /var/www/html/.
# wp --allow-root core download --path=/var/www/html/wordpress
sleep infinity