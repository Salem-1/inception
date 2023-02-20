# Bism Ellah Elrahman Eraheem

# Project specs:
1-Project done in virtual machine
2-All configuration files places in src folder
3-Makefile in the root of my directory,
4-Makefile setup the entire project using docker-compose.yml
5-Setting up infrastructure with different services in vm and must use
docker compose
6-Each image has same name as corrosponding service
7-Each service run in dedicated container
8-Containers run in penultimate stable debian or alpine
9-Write Dockerfile for each service then call it in docker-compose.yml
10-Docker container contains NGINX with TLSv1.2 or TLSv1.3
11-Docker container with wordpress + php installed and configured without nginx
12-Docker container with MariaDB without NGINX
13-Volume contains wordpress database on the host machine in (/home/<login>/data) "I believe you will mount bind it to your volumes"
14-Another volume contains website files on the host machine
15-Docker network establish connection bettween containers (network line must be present in docker-compose file)
16-Containers have to restart in case of crash
17-Create two users for your database one of them admin with Ahmed_salem name 
18-Configure domain name to points to my local IP address
19-The domain name must be ahsalem.42.fr
20-No password present in the docker files
21-Use .env file to store env. virables, located at root of src dir (use -e .env)
22-NGINX only entrypoint via port 443 (using TLSv1.2 or 1.3 protocol)
24-NGINX connects to wordpress php container with port 9000
25-NGINX and wordpress php mount to wordpress volume
26-Wordpress container connect to DB container port 3306
27-DB container mount to DB volume
# Notes:

Level 9 8
-Read about how daemons work, PID, best practices for writing docker file
-not allowed to use tail -f, network: host, --link, links, starting containers with infinite loops, entry point with bash, sleep, infinity, while True  (use wait opetion instead, illustrated down) or latest tag
-Awesome compose repo for docker compse examples
-Volume: can be made inside docker compose then specify thier location
	local

# Docker crash documentation:
=======
# Simple Docker documentaiton:
>>>>>>> 9dcdee7779223127b34f92577e21ad2b71559358

First clone the getting started repo 
	
	git clone https://github.com/docker/getting-started.git

Then cd to the app dir

	cd app
After that create Dockerfile
	touch Dockerfile
Now it's time to configure your Docker file, for example let's buid an alpine image as follows
N.B: in the COPY line there is a space bettween the "." and "."
18-alpine will take time to be downloaded
then yarn will install application dependencies
CMD define the default command to run after running the container from this image

	# syntax=docker/dockerfile:1

	FROM node:18-alpine
	WORKDIR /app
	COPY . .
	RUN yarn install --production
	CMD ["node", "src/index.js"]
	EXPOSE 3000

Then in the terminal build this image as follows by giving it name of "getting-started", "-t" tags your image name (Putting label on it), the "." means build the image in the same directory:
	
	docker build -t getting-started .


To start your app use the command below (-d means detached -running in the background-, -p stands for mapping between host and port 3000 )

	 docker run -dp 3000:3000 getting-started

Now you can access your todo application by visiting this url on your browser:

Finally you can doubel check your running app on the docker dashboard.

	http://localhost:3000

# 
To update the app in the container:

1- Go to app src files
2-Do the update
3-Stop the current process

	docker ps 

then get your container id

	docker stop <your container id>
4-Remove your old docker image

	docker rm <your container id>

N.B: you can do 3 and 4 in one step as follows

	docker rm -f <your container id>
5-Open your app, hopefully you will find the new updates.
But unfortunately all saved data are gone.

# 
Pushing to docker hub:
1-Create account on dockerhub
2-Create repo 
3-tag your container as follows

	 docker tag getting-started YOUR-USER-NAME/getting-started
4-push your container

	 docker push YOUR-USER-NAME/getting-started

N.B: you can get list your docker images using:

	docker image ls
6-To play with docker as online app:
1-login to playwithdocker
2-Start new instance
3-login in the opened terminal
4-run your docker app
4-click the portnumber that will appear 
Enjoy
3
#
Presisting data base:

-You can create container with a file inside in one command as follows

	docker run -d ubuntu bash -c "shuf -i 1-10000 -n 1 -o /data.txt && tail -f /dev/null"
if you go to Docker desktop you can run the terminal for your machine then,

	cat /data.txt

Otherwise you can directly execute commands in your running container by this command

	docker exec <container id> cat /data.txt

if you run another container you will see that you don't have the same file 

	docker run -it ubuntu ls

-Anohter approach to use Volumes:

1-Create your volume using 

	docker volume create <volume name>

N.B:stop and remove target container for sake of mounting the new volume to avoid confusion

2-Start your app with mounting the created volume to the target container 

	docker run -dp 3000:3000 --mount type=volume,src=<volume name>,target=/etc/<volume name inside container> <container name>

Then when you start your container, same some data to your volume inside the container then delete and start it again your will find your data

N.B:to know where your volume live on your local machine use this cmd:

	docker volume inspect <volume name>

#

# Putting container on network
To do so you can either:

-Assign it at start

Or

-Connet an existing container

For now let's create the network first then attach mysql container to it when starting it

1-Create docker network:

	docker network create todo-app

2-Start the mysql container and attach it to the network:

	docker run -d \
	--network todo-app --network-alias mysql \
	-v todo-mysql-data:/var/lib/mysql \
	-e MYSQL_ROOTPASSWORD=secret \
	-e MYSQL_DATABASE=todos \
	mysql:8.0

-v for creating volume or bind mount 
-e creats environment variable key=val

3-To make sure database is up and runnuing we will
First connect to the database
Second verify it connects

	docker exec -it <mysql-container-id> -u root -p
then type your password

	mysql> SHOW DATABASES;



this should be the output

	+--------------------+
	| Database           |
	+--------------------+
	| information_schema |
	| mysql              |
	| performance_schema |
	| sys                |
	| todos              |
	+--------------------+
	5 rows in set (0.00 sec)

then 
	mysql>exit

-u user id to run as, here will run as user 

# Connet to  MYSQL

First to figure out the ip address open the nicolaka-netshoot image (which has a lot of useful network tools)

	docker run -it --network todoapp  nicolaka-netshoot

Then inside the nicolaka

	dig mysql

then you should have the ip in the output of this dig

Now let's do the heavy lifting:
N.B: for mysql version 8.0 and higher, include the following command:

	mysql> ALTER USER 'root' IDENTIFIED WITH mysql_native_password BY 'secret';
 	mysql> flush privileges;

Time to connect our app to the database

	docker run -dp 3000:3000 \
	-w /app -v "$pwd:/app" \
	--network todo-app \
	-e MYSQL_HOST=mysql \ 
	-e MYSQL_USER=root \
	-e MYSQL_PASSWORD=secret \ 
	-e MYSQL_DP=todos \ 
	node:18-alpine \
	sh -c "yarn install && yarn run dev"

to double check that everything in place

	docker logs -f <container-id>
this shoudld show message indicating we are using mysql

Now run the app, add few items to fill your data base
Then you can check the update dabase as follows:

	docker exec -it <mysql-container-id>  mysql -p todos
then

	mysql>SELECT * FROM todo_items;

this should show the new added items
#
# Docker compose

Configuring compose file:

1-First Make sure that Docker compose is installed

	Docker compose version

2-Create docker-compose.yaml.
3- then configure as following example

	services:  #define the services that your app will do
	  app:   #application name
	    image: node:18-alpine    # the image to be used
	    command: sh -c "yarn install && yarn run dev"   #Buidling commands to run
	    ports:  #exposed ports
	      - 3000:3000
	    working_dir: /app     #-w
	    volumes:
	      - ./:/app
	    environment:  # defining environment variables
	      MYSQL_HOST: mysql
	      MYSQL_USER: root
	      MYSQL_PASSWORD: secret
	      MYSQL_DB: todos

	  mysql: #second app name
	    image: mysql:8.0
	    volumes:
	      - todo-mysql-data:/var/lib/mysql
	    environment:
	      MYSQL_ROOT_PASSWORD: secret
	      MYSQL_DATABASE: todos

	volumes:	#volumes has to be configured explicitly 
	  todo-mysql-data:

N.B:contaienrs doesn't wait for each other to run, if you wish to do so you can use  wait-port, example use case:

	    command: sh -c "/wait-for-it.sh mysql:3306 -t 30 && yarn install && yarn run dev"
#
Running the application:

	docker compose up -d


To see the logs:

	docker compose logs -f 
#
Deleting the composed app

	docker compose down

To delete the app along with the volumes

	docker compose down --volume
=======
Using bind command:
It allows you to share same storage in your local machine and image, in other words after choosing src and target path, what will be saved on src will be reflected on target and vice versa, Also you don't have to have all build tools and environments installed on your container
To see this in action follow the following steps:
1-cd to your app location
2-Run the following cmd

	docker run -it --mount type=bind,src="$(PWD)",target=/src ubuntu bash

-i for interactive mode
-t for tty, will create pseudo tty allow you to use it as terminal
bash command to open the bash
Now any change you make in the src dir will be reflect on your current path and vice versa
#
Running app in a development container:
1-Make sure you stop your target container
2-Go to your app dir
3-Type this command in linux and mac

	docker run -dp 3000:3000 \
    -w /app --mount type=bind,src="$(pwd)",target=/app \
    node:18-alpine \
    sh -c "yarn install && yarn run dev"
if you are using windows run this one

	docker run -dp 3000:3000 `
    -w /app --mount type=bind,src="$(pwd)",target=/app `
    node:18-alpine `
    sh -c "yarn install && yarn run dev"
-d detached mode, run in the background as per my understanding
-p port mapping, means will use port 3000 to access it
-w working directory or current directory the command will run from
node:18-alpine the image we are using for our container
sh yarn install : alpine doesn't have bash, yarn install will install packages
yarn run dev: will run in development server

To make sure you are ready to run your server run the following cmd:
	
	docker logs -f <container-id>
Now any change you make to your src code will be reflected automatically on your app running in the container

After you are done stop your container and build new imgae using 

	docker build -t getting-started .
Ref:https://docs.docker.com/get-started/02_our_app/