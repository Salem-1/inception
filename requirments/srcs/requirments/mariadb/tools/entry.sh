#!/bin/bash

echo "Starting the mysql service!"
service mysql start 
sleep 5
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; \
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
	FLUSH PRIVILEGES;"

# GRANT CREATE USER ON *.* TO 'root'@'localhost'; \
sleep 5
echo Running the mysql service!
echo admin $MYSQL_USER should created, if you see database created, you are good to go!
mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;"
mysqld --bind-address=0.0.0.0 
