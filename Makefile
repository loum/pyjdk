.SILENT:
.DEFAULT_GOAL := help

#
# Makester overrides.
#
MAKESTER__STANDALONE := true
MAKESTER__INCLUDES=py docker
MAKESTER__REPO_NAME := loum
MAKESTER__CONTAINER_NAME := pyjdk

include $(HOME)/.makester/makefiles/makester.mk

# Container image build.
PYTHON_MAJOR_MINOR_VERSION ?= 3.13
OPENJDK_11_HEADLESS_MAIN ?= 11.0.25
export OPENJDK_11_HEADLESS_VERSION ?= $(OPENJDK_11_HEADLESS_MAIN)+9-1ubuntu1~24.04
# Tagging convention used: openjdk.<OPENJDK_11_HEADLESS_VERSION>-<MAKESTER__RELEASE_NUMBER>
MAKESTER__VERSION ?= openjdk-$(OPENJDK_11_HEADLESS_MAIN)
MAKESTER__RELEASE_NUMBER ?= 1

UBUNTU_BASE_IMAGE ?= loum/python3-ubuntu:noble-$(PYTHON_MAJOR_MINOR_VERSION)
BUILD_PYSPARK_VERSION ?= ""

MAKESTER__BUILD_COMMAND = --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=$(UBUNTU_BASE_IMAGE)\
 --build-arg OPENJDK_11_HEADLESS_VERSION=$(OPENJDK_11_HEADLESS_VERSION)\
 --build-arg BUILD_PYSPARK_VERSION=$(BUILD_PYSPARK_VERSION)\
 -t $(MAKESTER__IMAGE_TAG_ALIAS) .

# Makester container image run command.
CMD :=
MAKESTER__RUN_COMMAND := $(MAKESTER__DOCKER) run --rm -ti\
 --name $(MAKESTER__CONTAINER_NAME)\
 --env PYSPARK_VERSION=$(BUILD_PYSPARK_VERSION)\
 $(MAKESTER__SERVICE_NAME):$(HASH) $(CMD)

MAKESTER__IMAGE_TARGET_TAG ?= $(HASH)

#
# Local Makefile targets.
#
# Initialise the development environment.
init: py-venv-clear py-venv-init py-install-makester

image-bulk-build:
	$(info ### Container image bulk build ...)
	scripts/bulkbuild.sh

image-pull-into-docker:
	$(info ### Pulling local registry image $(MAKESTER__SERVICE_NAME):$(HASH) into docker)
	$(MAKESTER__DOCKER) pull $(MAKESTER__SERVICE_NAME):$(HASH)

image-tag-in-docker: image-pull-into-docker
	$(info ### Tagging local registry image $(MAKESTER__SERVICE_NAME):$(HASH) for docker)
	$(MAKESTER__DOCKER) tag $(MAKESTER__SERVICE_NAME):$(HASH) $(MAKESTER__STATIC_SERVICE_NAME):$(HASH)

image-transfer: image-tag-in-docker
	$(info ### Deleting pulled local registry image $(MAKESTER__SERVICE_NAME):$(HASH))
	$(MAKESTER__DOCKER) rmi $(MAKESTER__SERVICE_NAME):$(HASH)

multi-arch-build: image-registry-start image-buildx-builder
	$(info ### Starting multi-arch builds ...)
	$(MAKE) MAKESTER__DOCKER_PLATFORM=linux/arm64,linux/amd64 image-buildx
	$(MAKE) image-transfer
	$(MAKE) image-registry-stop

help: makester-help
	@echo "(Makefile)\n\
  init                 Build the local development environment\n\
  image-bulk-build     Build all multi-platform container images\n\
  multi-arch-build     Convenience target for multi-arch container image builds\n"

.PHONY: help
