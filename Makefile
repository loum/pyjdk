.SILENT:
.DEFAULT_GOAL := help

MAKESTER__REPO_NAME := loum

PYTHON3_VERSION := 3.8.10
OPENJDK_11_VERSION := 11.0.13

# Tagging convention used: <PYTHON3_VERSION>-<OPENJDK_11_VERSION>-<MAKESTER__RELEASE_NUMBER>
MAKESTER__VERSION = $(PYTHON3_VERSION)-$(OPENJDK_11_VERSION)
MAKESTER__RELEASE_NUMBER = 1

include makester/makefiles/makester.mk
include makester/makefiles/docker.mk
include makester/makefiles/python-venv.mk

UBUNTU_BASE_IMAGE := focal-20220113
OPENJDK_11_HEADLESS := $(OPENJDK_11_VERSION)+8-0ubuntu1~20.04
PYTHON3_RELEASE := $(PYTHON3_VERSION)-0ubuntu1~20.04.2
PYTHON3_PIP := 20.0.2-5ubuntu1.6

MAKESTER__BUILD_COMMAND = $(DOCKER) build --rm\
 --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$(UBUNTU_BASE_IMAGE)\
 --build-arg OPENJDK_11_HEADLESS=$(OPENJDK_11_HEADLESS)\
 --build-arg PYTHON3_RELEASE=$(PYTHON3_RELEASE)\
 --build-arg PYTHON3_PIP=$(PYTHON3_PIP)\
 -t $(MAKESTER__IMAGE_TAG_ALIAS) .

MAKESTER__CONTAINER_NAME := pyspark-helper
MAKESTER__RUN_COMMAND := $(DOCKER) run --rm -ti\
 --name $(MAKESTER__CONTAINER_NAME)\
 $(MAKESTER__SERVICE_NAME):$(HASH) $(CMD)

MAKESTER__IMAGE_TARGET_TAG = $(HASH)

init: clear-env makester-requirements

python:
	$(MAKE) run CMD='bash -c "python3"'

python-version:
	$(MAKE) run CMD='bash -c "python3 --version"'

help: makester-help docker-help python-venv-help
	@echo "(Makefile)\n\
  login                Login to container $(MAKESTER__CONTAINER_NAME) as user \"hdfs\"\n\
  python-version       Python3 version\n\
  python               Start the Python3 interpreter\n"

.PHONY: help
