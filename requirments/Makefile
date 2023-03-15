
LOCATION = -f ./srcs/docker-compose.yml
all: vols run


run: build up
# build up
vols:
	mkdir -p /home/${USER}/data/DB
	mkdir -p /home/${USER}/data/wordpress
build:
	sudo docker compose --env-file ./srcs/.env $(LOCATION)   build 
up:
	sudo docker compose --env-file ./srcs/.env  $(LOCATION)  up 

down:
	sudo docker compose $(LOCATION) stop
	sudo docker compose $(LOCATION)	 down
	sudo docker compose $(LOCATION) down --remove-orphans
	sudo docker compose $(LOCATION) down --volumes --remove-orphans

logs:
	
clean: down prune 
	docker rm $(docker ps -a -q)

prune: down
	sudo docker system prune -a 
	sudo docker system prune -a --volumes 
	sudo docker system prune

clean_vol:
	sudo chmod 777 /home/${USER}/data/wordpress
	sudo chmod 777 /home/${USER}/data/wordpress/*
	sudo rm -rf /home/${USER}/data/DB
	sudo rm -rf /home/${USER}/data/wordpress

rv:
	docker volume prune --force

re :down all