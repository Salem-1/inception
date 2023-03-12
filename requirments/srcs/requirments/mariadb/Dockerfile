FROM debian:buster

ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_PASSWORD
ARG MYSQL_USER
ARG MYSQL_DATABASE
ARG ADMIN
ARG ADMIN_PASSWORD

# ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
# ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
# ENV MYSQL_USER=${MYSQL_USER}
# ENV MYSQL_DATABASE=${MYSQL_DATABASE}

EXPOSE 3306
RUN apt-get update -y 
RUN apt-get upgrade -y 
RUN apt-get install  mariadb-server -y
CMD ["/bin/entry.sh"]
# RUN mkdir -p /var/run/mysql
# RUN chown -R mysql:mysql /var/run/mysql
RUN service mysql start
# RUN service mysql  start && mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};\
# GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';\
# FLUSH PRIVILEGES;"

COPY ./tools/entry.sh /bin/.
COPY conf/mysql.conf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /bin/entry.sh
COPY conf/my.conf /etc/mysql/my.conf
# RUN mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
# RUN mysql -u root -p$MYSQL_ROOT_PASSWORD  -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# # mysql GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; \
# RUN mysql -u root -p$MYSQL_ROOT_PASSWORD  -e "FLUSH PRIVILEGES;" 
# # ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; \
# # 	FLUSH PRIVILEGES;"
# RUN service mysql start

