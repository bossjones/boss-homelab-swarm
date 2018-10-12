username := bossjones
container_name := elasticsearch

GIT_BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
GIT_SHA     = $(shell git rev-parse HEAD)
BUILD_DATE  = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
VERSION     = $(shell cat ./version.txt)

TAG ?= $(VERSION)
ifeq ($(TAG),@branch)
	override TAG = $(shell git symbolic-ref --short HEAD)
	@echo $(value TAG)
endif

build:
	docker build --tag $(username)/$(container_name):$(GIT_SHA) . ; \
	docker tag $(username)/$(container_name):$(GIT_SHA) $(username)/$(container_name):latest
	docker tag $(username)/$(container_name):$(GIT_SHA) $(username)/$(container_name):$(TAG)

build-force:
	docker build --rm --force-rm --pull --no-cache -t $(username)/$(container_name):$(GIT_SHA) . ; \
	docker tag $(username)/$(container_name):$(GIT_SHA) $(username)/$(container_name):latest
	docker tag $(username)/$(container_name):$(GIT_SHA) $(username)/$(container_name):$(TAG)

tag:
	docker tag $(username)/$(container_name):$(GIT_SHA) $(username)/$(container_name):latest
	docker tag $(username)/$(container_name):$(GIT_SHA) $(username)/$(container_name):$(TAG)

build-push: build tag
	docker push $(username)/$(container_name):latest
	docker push $(username)/$(container_name):$(GIT_SHA)
	docker push $(username)/$(container_name):$(TAG)

push:
	docker push $(username)/$(container_name):latest
	docker push $(username)/$(container_name):$(GIT_SHA)
	docker push $(username)/$(container_name):$(TAG)

push-force: build-force push

# test: build
# 	docker run -p 9200:9200 --name elasticsearch veltra/elasticsearch; sleep 15
# 	docker run --network container:elasticsearch appropriate/curl --retry 10 --retry-connrefused -u $(ELASTICSEARCH_USERNAME):$(ELASTICSEARCH_PASSWORD) http://localhost:9200

# # Push the image to the dedicated push endpoint at "push.docker.elastic.co"
# push: test
# 	$(foreach FLAVOR, $(IMAGE_FLAVORS), \
# 	  docker tag $(IMAGE_TAG)-$(FLAVOR):$(VERSION_TAG) push.$(IMAGE_TAG)-$(FLAVOR):$(VERSION_TAG); \
# 	  docker push push.$(IMAGE_TAG)-$(FLAVOR):$(VERSION_TAG); \
# 	  docker rmi push.$(IMAGE_TAG)-$(FLAVOR):$(VERSION_TAG); \
# 	)
# 	# Also push the default version, with no suffix like '-oss' or '-x-pack'
# 	docker tag $(IMAGE_TAG):$(VERSION_TAG) push.$(IMAGE_TAG):$(VERSION_TAG);
# 	docker push push.$(IMAGE_TAG):$(VERSION_TAG);
# 	docker rmi push.$(IMAGE_TAG):$(VERSION_TAG);


.PHONY: default deploy deploy-logging create-networking

default: deploy

deploy-logging:
	@docker stack deploy -c docker-stack.yml logging

rm-logging:
	@docker stack rm -c docker-stack.yml logging

deploy: deploy-logging

create-networking:
	docker network create --driver overlay --subnet=10.0.9.0/24 home-web
	docker network create --driver overlay --subnet=10.0.10.0/24 home-docker
	docker network create --driver overlay --subnet=10.0.11.0/24 home-monitoring
	docker network ls

bash:
	docker run -it \
	--rm \
	-p 9200:9200 \
	-p 9300:9300 \
	--memory="600M" \
	--cpus="1.5" \
	--mount type=bind,src=$(pwd)/config/elasticsearch.yml,dst=/usr/share/elasticsearch/config/elasticsearch.yml \
	--mount type=bind,src=$(pwd)/config/elasticsearch.jvm.options,dst=/usr/share/elasticsearch/config/jvm.options \
	--env xpack.graph.enabled="false" \
	--env http.host='0.0.0.0' \
	--env discovery.zen.minimum.master.nodes='1' \
	--env discovery.type='single-node' \
	--env ES_JAVA_OPTS="${ES_JAVA_OPTS}" \
	docker.io/bossjones/elasticsearch:5.6.1 bash
