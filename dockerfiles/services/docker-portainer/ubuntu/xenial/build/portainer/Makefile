.PHONY: default deploy deploy-portainer create-networking

default: deploy

deploy-portainer:
	@docker stack deploy -c docker-stack.yml portainer
	@docker stack deploy -c docker-stack.yml agent

deploy: deploy-portainer

create-networking:
	docker network create --driver overlay --subnet=10.0.9.0/24 home-web
	docker network create --driver overlay --subnet=10.0.10.0/24 home-docker
	docker network create --driver overlay --subnet=10.0.11.0/24 home-monitoring
	docker network ls
