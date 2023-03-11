DOCKER_COMPOSE_FILE=srcs/docker-compose.yml

up:
	docker-compose -f ${DOCKER_COMPOSE_FILE} up

down:
	docker-compose -f ${DOCKER_COMPOSE_FILE} down

build:
	docker-compose -f ${DOCKER_COMPOSE_FILE} up --build
