DOCKER_COMPOSE_COMMAND=docker-compose -f srcs/docker-compose.yml

.PHONY: all
all: down prune up

.PHONY: up
up: host
	${DOCKER_COMPOSE_COMMAND} up --build

.PHONY: down
down:
	${DOCKER_COMPOSE_COMMAND} down

.PHONY: prune
prune: down vc
	docker system prune -f

.PHONY: vc
vc: down
	rm -rf ~/data

.PHONY: host
host:
	cat /etc/hosts | grep "127.0.0.1 rnishimo.42.fr" >/dev/null || echo "127.0.0.1 rnishimo.42.fr" >> /etc/hosts
