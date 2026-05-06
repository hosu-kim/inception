DATA_DIR	= /home/hoskim/data
WP_DIR		= $(DATA_DIR)/wordpress
DB_DIR		= $(DATA_DIR)/mariadb

all: init up

init:
	@mkdir -p $(WP_DIR) $(DB_DIR)

up:
	@docker compose -f srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@docker compose -f srcs/docker-compose.yml --env-file srcs/.env down

stop:
	@docker compose -f srcs/docker-compose.yml --env-file srcs/.env stop

clean: down
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo rm -rf $(DATA_DIR)

fclean: clean
	@docker rmi -f $$(docker images -qa) 2>/dev/null || true

re: fclean all

.PHONY: all init up down stop clean fclean re
