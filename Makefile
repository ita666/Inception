#creat 'data' folder in /home/yanthoma/

all: 
	cp /home/yanthoma/.env ./srcs/
	mkdir -p /home/yanthoma/data/mariadb
	mkdir -p /home/yanthoma/data/wordpress
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

clean:
	docker compose -f ./srcs/docker-compose.yml down
	docker system prune -af
	rm ./srcs/.env

fclean: clean
	sudo rm -rf /home/yanthoma/data/mariadb/*
	sudo rm -rf /home/yanthoma/data/wordpress/*

re: fclean all

.Phony: all logs clean fclean