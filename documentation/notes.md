What is docker?
What is docker image?
How to build one?
What is Docker-compose.yaml?

What is virtualization? What is virtual machine?
What is system administration?
What is system adminstration using docker?
Albien vs debian images, And which one to choose?
Keywords:
Docker, Serivces, Infrastructure






Requirments:
1-Place configuration file in srcs folder
2-Make file at the root of my directory:
	-Set up the whole application the whole application using
	-Has to build upd docker images using docker-compose.yaml
3 A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
4 A Docker container that contains WordPress + php-fpm (it must be installed and
configured) only without nginx.
5 A Docker container that contains MariaDB only without nginx.
6 A volume that contains your WordPress database.
7 A second volume that contains your WordPress website files.
8 A docker-network that establishes the connection between your containers.