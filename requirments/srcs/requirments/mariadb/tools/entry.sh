#!/bin/bash
# sleep infinity
mysqld --user=mysql &
sleep 10
mysqladmin --user=mysql -u root password "$MYSQL_ROOT_PASSWORD"
mysql --user=mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE $MYSQL_DATABASE;\
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';\
CREATE USER '$ADMIN'@'%' IDENTIFIED BY '$ADMIN_PASSWORD'; \
 GRANT ALL PRIVILEGES ON *.* TO '$ADMIN'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

mysql --user=mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE test;
FLUSH PRIVILEGES;
GRANT USAGE ON *.* to 'root'@'%' identified by 'MYSQL_ROOT_PASSWORD' with grant option;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;"

LOG_FILE=/var/log/mysql/mysql.log
ERR_FILE=/var/log/mysql/error.log
LOG_LINK=/dev/stdout
ERR_LINK=/dev/stderr

# Remove the MySQL log and error files
rm $LOG_FILE
rm $ERR_FILE

# Create symbolic links to stdout and stderr for the log file
ln -s $LOG_LINK $LOG_FILE
ln -s $ERR_LINK $ERR_FILE

#installing ps for debugging purpose
# apt-get install procps -y
# # echo "Starting the mysql service!"
# service mysql start 
# mysqld_safe &      
# sleep 20
# sleep infinity
# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$ADMIN'@'%' IDENTIFIED BY '$ADMIN_PASSWORD'; \
#  GRANT ALL PRIVILEGES ON *.* TO '$ADMIN'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; \
# ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
# GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
# FLUSH PRIVILEGES;"

# # mysql -u root -p$MYSQL_ROOT_PASSWORD -e ";"
# # GRANT CREATE USER ON *.* TO 'root'@'localhost'; \
# # sleep infinity
# echo Running the mysql service!
# echo admin $MYSQL_USER should created, if you see database created, you are good to go!
# # mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;"
# # mysql stop
# sleep infinity
# mysqld_safe  --bind-address=0.0.0.0 

# RUN mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}; \
# 	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; \
# 	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; \
# 	FLUSH PRIVILEGES;"


# ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (111), 
#I am runing dockerfile and using docker compose
# ANSWER
# The error message "ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (111)" occurs when the MySQL server cannot be found at the specified location or is not running [0]. There can be various causes for this error, such as missing or corrupted MySQL server, misconfiguration in the my.cnf file, or issues with socket file access or directory permissions. Here are some steps to troubleshoot and resolve this error:

# Check if MySQL server is installed and running on your computer. To check if MySQL server is running, use the command ps ax | grep mysql. If MySQL server is not running, start it using the command sudo service mysql start or sudo /etc/init.d/mysql start depending on the Linux distribution [1].
# Make sure that the socket file exists at the specified location. The socket file is usually created when MySQL server is started and removed when you stop the server. If the file is missing, you can create it manually or by starting the MySQL server. Check the my.cnf file for the correct socket file configuration. The my.cnf file can be located at /etc/my.cnf, /etc/mysql/my.cnf, or /var/lib/mysql/my.cnf. If there are conflicting configurations, remove or rename the my.cnf file and let MySQL use the default configuration [0].
# Check the directory permissions for the socket file location. If the directory does not exist or is not accessible by MySQL server, create it and set the correct permissions. For example, you can use the command sudo install -o mysql -g mysql -m 0700 -d /var/lib/mysql-files to create the directory /var/lib/mysql-files and set the owner and permission. Then start the MySQL server using systemctl start mysql [4].
# Validate the MySQL server status and fix any configuration conflicts. Check the MySQL server logs for specific errors and take appropriate action. If the issue persists, try uninstalling and reinstalling MySQL server. This can be done using the command sudo apt-get remove --purge mysql* to remove all MySQL packages, followed by sudo apt-get autoremove, sudo apt-get autoclean, and sudo apt-get install mysql-server mysql-client to reinstall MySQL server [1].
# Here are some additional commands that can be used to diagnose and fix the error:

# mysql -h 127.0.0.1 -P 3306 -u root -p <database>: Use this command to connect to the MySQL server using TCP/IP protocol instead of the socket file. Replace <database> with the name of the database you want to connect to [0].
# telnet 127.0.0.1 3306: Use this command to check if the MySQL server is listening on the TCP/IP port 3306. If the command fails, it means the server is not running or there is a firewall blocking the port [0].
# sudo apt-get install mysql-server: Use this command to install MySQL server on Ubuntu [0].
# In summary, the "ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (111)" error can be caused by various issues related to MySQL server installation, configuration, or access. By checking the server status, verifying the socket file and directory permissions, and fixing any configuration conflicts, you can troubleshoot and resolve this error.