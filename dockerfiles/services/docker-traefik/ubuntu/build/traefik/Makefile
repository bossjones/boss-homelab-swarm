.PHONY: default deploy deploy-traefik create-networking

default: deploy

deploy-traefik:
	@docker stack deploy -c docker-stack.yml traefik

rm-traefik:
	@docker stack rm -c docker-stack.yml traefik

deploy: deploy-traefik

create-networking:
	docker network create --driver overlay --subnet=10.0.9.0/24 home-web
	docker network create --driver overlay --subnet=10.0.10.0/24 home-docker
	docker network create --driver overlay --subnet=10.0.11.0/24 home-monitoring
	docker network create -d overlay home-traefik
	docker network ls


