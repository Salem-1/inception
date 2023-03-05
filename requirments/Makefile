
LOCATION = -f ./srcs/docker_compose.yml
all: run


run: build
	sudo docker compose --env-file ./srcs/.env  $(LOCATION) up -d
# build up

build:
	sudo docker compose --env-file ./srcs/.env $(LOCATION)   build
up:
	sudo docker compose --env-file ./srcs/.env  $(LOCATION) up -d

down:
	sudo docker compose $(LOCATION) stop
	sudo docker compose $(LOCATION)	 down
	sudo docker compose $(LOCATION) down --remove-orphans

clean:
	docker rm $(docker ps -a -q)

prune: 
	docker system prune -a 
	docker system prune -a --volumes 

re :down all