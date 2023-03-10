#!/bin/bash

# apt-get install procps -y
# # echo "Starting the mysql service!"
# service mysql start 
mysqld_safe &
sleep 10
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; \
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
FLUSH PRIVILEGES;"


mysql -u root -p$MYSQL_ROOT_PASSWORD -e ";"
# GRANT CREATE USER ON *.* TO 'root'@'localhost'; \
# sleep infinity
echo Running the mysql service!
echo admin $MYSQL_USER should created, if you see database created, you are good to go!
# mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;"
# # mysql stop
# sleep infinity
mysqld_safe  --bind-address=0.0.0.0 

# RUN mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}; \
# 	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; \
# 	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; \
# 	FLUSH PRIVILEGES;"