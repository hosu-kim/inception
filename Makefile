NAME = inception
LOGIN = hoskim
DATA_DIR = /home/$(LOGIN)/data

all: up

up: setup
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

stop:
	docker compose -f srcs/docker-compose.yml stop

start:
	docker compose -f srcs/docker-compose.yml start

clean:
	docker compose -f srcs/docker-compose.yml down -v
	sudo rm -rf $(DATA_DIR)

fclean: clean
	docker system prune -af

re: fclean all

setup:
	mkdir -p $(DATA_DIR)/mariadb
	mkdir -p $(DATA_DIR)/wordpress

.PHONY: all up down stop start clean fclean re setup
