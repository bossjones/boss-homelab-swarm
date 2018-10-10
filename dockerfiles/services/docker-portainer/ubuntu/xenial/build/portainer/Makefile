.PHONY: default build dependencies image

default: build

build:
	CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" -o whoami

dependencies:
	dep ensure -v

image:
	docker build -t containous/whoami .

deploy-portainer:
	@docker stack deploy -c docker-stack.yml portainer
	@docker stack deploy -c docker-stack.yml agent

create-networking:
	docker network create --driver overlay --subnet=10.0.9.0/24 home-web
	docker network create --driver overlay --subnet=10.0.10.0/24 home-docker
	docker network create --driver overlay --subnet=10.0.11.0/24 home-monitoring
	docker network ls
