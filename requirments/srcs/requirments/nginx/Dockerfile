FROM debian:buster

RUN apt-get update -y &&  apt-get upgrade -y 
RUN  apt-get install nginx -y  openssl
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/ahsalem.42.fr.key -out \
/etc/nginx/ssl/ahsalem.42.fr.crt -subj "/C=AD/ST=AbuDhabi/L=Mina/O=42AbuDhabi/CN=ahsalem.42.fr"
COPY conf/nginx.conf 	/etc/nginx/conf.d/default.conf
EXPOSE 443
CMD ["nginx", "-g", " daemon off;"]x