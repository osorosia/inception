.PHONY: all
all: up

.PHONY: up
up:
	docker-compose up --build

.PHONY: down
down:
	docker-compose down

.PHONY: vc
vc: down
	rm -rf volume_*

.PHONY: ic
ic: down
	docker image rm -f `docker image ls -q`


.PHONY: cache
cache: down
	docker builder prune
