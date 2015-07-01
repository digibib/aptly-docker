.PHONY: all

all: reload build run

reload: halt up provision

halt:
	vagrant halt

up:
	vagrant up

provision:
	vagrant provision

build:
	@echo "======= BUILDING APTLY IMAGE ======\n"
	vagrant ssh -c 'docker build -t digibib/aptly /vagrant/latest'

stop: 
	@echo "======= STOPPING APTLY CONTAINER ======\n"
	vagrant ssh -c 'docker stop aptly_docker' || true

delete: stop
	@echo "======= DELETING APTLY CONTAINER ======\n"
	vagrant ssh -c 'docker rm aptly_docker' || true

REPO ?= /tmp/aptly
run: delete     ## start new aptly_docker -- args: REPO
	@echo "======= RUNNING APTLY CONTAINER ======\n"
	vagrant ssh -c 'docker run -d --name aptly_docker \
	-v "$(REPO):/aptly" \
	-t digibib/aptly:latest' || echo "aptly_docker container already running, please 'make delete' first"

logs-f:
	vagrant ssh -c 'docker logs -f aptly_docker'

login:	# needs EMAIL, PASSWORD, USERNAME
	vagrant ssh -c 'docker login --email=$(EMAIL) --username=$(USERNAME) --password=$(PASSWORD)''

tag = "$(shell git rev-parse HEAD)"
push:
	@echo "======= PUSHING APTLY IMAGE ======\n"
	vagrant ssh -c 'docker tag digibib/aptly digibib/aptly:$(tag)'
	vagrant ssh -c 'docker push digibib/aptly'

