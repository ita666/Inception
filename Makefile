#creat 'data' folder in /home/yanthoma/

all: 
	@if [ ! -e "srcs/.env" ]; then \
		if [ -e "/home/yanthoma/.env" ]; then \
			cp /home/yanthoma/.env srcs/.env; \
		fi; \
	fi;
	mkdir -p /home/yanthoma/data/mariadb
	mkdir -p /home/yanthoma/data/wordpress
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

clean:
	@if [ -e "srcs/.env" ]; then \
		docker compose -f ./srcs/docker-compose.yml down; \
	else \
		echo "Warning: .env file is missing. Docker compose services may not be stopped correctly."; \
	fi;
	-docker system prune -af
	rm -f ./srcs/.env

fclean: clean
	sudo rm -rf /home/yanthoma/data/mariadb/*
	sudo rm -rf /home/yanthoma/data/wordpress/*

re: fclean all

.Phony: all logs clean fclean