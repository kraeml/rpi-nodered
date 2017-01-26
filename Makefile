DOCKER_IMAGE_VERSION=0.2
DOCKER_IMAGE_NAME=kraeml/rpi-nodered
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset
	docker build -t $(DOCKER_IMAGE_TAGNAME) .
	docker tag $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

#test:
#	docker run --rm $(DOCKER_IMAGE_TAGNAME) /bin/echo "Success."

#version:
#	docker run --rm --privileged multiarch/qemu-user-static:register --reset
#	docker run --rm $(DOCKER_IMAGE_TAGNAME) 'node-red --version'

rmi:
	docker rmi -f $(DOCKER_IMAGE_TAGNAME)

rebuild: rmi build
