FROM debian:10

ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_PASSWORD
ARG MYSQL_USER
ARG MYSQL_DATABASE

ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y mariadb-server
RUN mkdir -p /var/run/mysql
RUN chown -R mysql /var/run/mysql

COPY ./tools/entry.sh /bin/.
COPY conf/mysql.conf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /bin/entry.sh

EXPOSE 3306


CMD ["/bin/entry.sh"]