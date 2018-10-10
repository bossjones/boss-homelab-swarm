.PHONY: default build dependencies image

default: build

build:
	CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" -o whoami

dependencies:
	dep ensure -v

image:
	docker build -t containous/whoami .

deploy-whoami:
	@docker stack deploy -c docker-compose.yml whoami
