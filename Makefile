.PHONY: all

all: build run

build:
	@echo "======= BUILDING APTLY IMAGE ======\n"
	sudo docker build -t digibib/aptly ./latest

stop: 
	@echo "======= STOPPING APTLY CONTAINER ======\n"
	sudo docker stop aptly_docker || true

delete: stop
	@echo "======= DELETING APTLY CONTAINER ======\n"
	sudo docker rm aptly_docker || true

REPO ?= /tmp/aptly
run: delete     ## start new aptly_docker -- args: REPO
	@echo "======= RUNNING APTLY CONTAINER ======\n"
	sudo docker run --name aptly_docker \
	-v "$(REPO):/aptly" \
	-t digibib/aptly:latest || echo "aptly_docker container already running, please 'make delete' first"

logs-f:
	sudo docker logs -f aptly_docker

login:	# needs EMAIL, PASSWORD, USERNAME
	sudo docker login --email=$(EMAIL) --username=$(USERNAME) --password=$(PASSWORD)

tag = "$(shell git rev-parse HEAD)"
push:
	@echo "======= PUSHING APTLY IMAGE ======\n"
	sudo docker tag digibib/aptly digibib/aptly:$(tag)
	sudo docker push digibib/aptly

