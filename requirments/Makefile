
LOCATION = -f ./srcs/docker_compose.yml
all: run


run:
	sudo docker compose $(LOCATION) up --build
# build up

build:
	sudo docker compose $(LOCATION) build
up:
	sudo docker compose $(LOCATION) up

down:
	sudo docker compose $(LOCATION)  down

clean:
	docker rm $(docker ps -a -q)

prune: clean
	sudo docker system prune -a
	sudo docker system prune -a --volumes

re :down all