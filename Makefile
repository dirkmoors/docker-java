###################################################
# Java Base Image
###################################################
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

TAG ?= ditchitall/java:8

all: show_vars build push

.PHONY: show_vars
show_vars:
	@ echo "########################################################################################"
	@ echo "# Java"
	@ echo "########################################################################################"
	@ echo "# ROOT_DIR:                   $(ROOT_DIR)"
	@ echo "# TAG:                        $(TAG)"
	@ echo "########################################################################################"
	@ echo

.PHONY: build
build:
	docker build -t ${TAG} .

.PHONY: push
push:
	docker push ${TAG}