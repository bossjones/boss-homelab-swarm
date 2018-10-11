
.PHONY: default deploy deploy-logging create-networking

default: deploy

build:
	CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" -o whoami

dependencies:
	dep ensure -v

image:
	docker build -t containous/whoami .

deploy-whoami:
	@docker stack deploy -c docker-stack.yml whoami

rm-whoami:
	@docker stack rm whoami

deploy: deploy-whoami

create-networking:
	docker network create --driver overlay --subnet=10.0.9.0/24 home-web
	docker network create --driver overlay --subnet=10.0.10.0/24 home-docker
	docker network create --driver overlay --subnet=10.0.11.0/24 home-monitoring
	docker network create --driver overlay traefik_net
	docker network ls
