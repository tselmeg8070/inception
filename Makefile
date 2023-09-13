all:
	docker-compose -f srcs/docker-compose.yml up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

re:
	docker-compose -f srcs/docker-compose.yml up -d --build

clean: down
	docker system prune -a
	sudo rm -rf /home/tadiyamu/data/wordpress/*
	sudo rm -rf /home/tadiyamu/data/mariadb/*

.PHONY: all re down clean