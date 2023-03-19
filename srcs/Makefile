# TODO: create command to add user to `docker` group
.PHONY: all
all: up

.PHONY: up
up: down vc
	docker-compose up --build

.PHONY: down
down:
	docker-compose down

prune: down vc cache
	docker system prune -f

.PHONY: vc
vc: down
	rm -rf volume_*

.PHONY: ic
ic: down
	docker image rm -f `docker image ls -q`

.PHONY: cache
cache: down
	yse | docker builder prune

.PHONY: wordpress w
wordpress w:
	docker-compose run wordpress sh
