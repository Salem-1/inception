all: build up

build:
	srcs/docker compose build
up:
	srcs/docker compose up

down:
	srcs/docker compose down

clean: down
	docker rm $(docker ps -a -q)

fclean: clean
	docker system prune -a
	docker system prune -a --volumes

re :clean a