REPO ?= mrsabath/web-ms
TAG ?= $(shell git rev-parse --short HEAD)
IMAGE := $(REPO):$(TAG)
MUTABLE_IMAGE := $(REPO):v3

all: docker-build docker-push timestamp

docker-build:
	docker build -t $(IMAGE) -f Dockerfile .
	docker tag $(IMAGE) $(MUTABLE_IMAGE)
docker-push:
	docker push $(IMAGE)
	docker push $(MUTABLE_IMAGE)
timestamp:
	date
