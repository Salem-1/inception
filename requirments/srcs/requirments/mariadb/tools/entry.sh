#!/bin/bash

echo "Starting the mysql service!"
service mysql start
echo "Setting the admin user and pass"
sleep 5

mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; \
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
CREATE USER $MYSQL_USER IDENTIFIED BY '$MYSQL_PASSWORD'; \
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
FLUSH PRIVILEGES;"

echo amin $MYSQL_USER created !
