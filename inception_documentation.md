# Bism Ellah Elrahman Eraheem

# Simple Docker commands:

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



Ref:https://docs.docker.com/get-started/02_our_app/