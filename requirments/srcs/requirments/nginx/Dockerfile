FROM debian:10

RUN apt-get update -y &&  apt-get upgrade -y 
RUN  apt-get install nginx -y 

COPY conf/nginx.conf  /etc/nginx/conf.d/default.conf
COPY index.html  /usr/share/nginx/html/.
EXPOSE 443
# EXPOSE 80
# CMD ["sleep", "infinity"]
#to run our process as PID 1,to be able to automatically restart the contaier if something wrong happened

#the exec command at the ned of CMD shell scrip inherit the PID 1
CMD ["/usr/sbin/nginx ", "-g", " daemon off;"]