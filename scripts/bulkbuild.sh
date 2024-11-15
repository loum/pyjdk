#!/bin/sh

for PYTHON_VERSION in 3.8 3.9 3.10 3.11 3.12
do
    docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=loum/python3-ubuntu:noble-$PYTHON_VERSION\
 --build-arg OPENJDK_11_HEADLESS_VERSION="$OPENJDK_11_HEADLESS_VERSION"\
 --build-arg BUILD_PYSPARK_VERSION=""\
 -t loum/pyjdk:python$PYTHON_VERSION-openjdk11 .
done

# Latest.
PYTHON_VERSION=3.13
docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=loum/python3-ubuntu:noble-$PYTHON_VERSION\
 --build-arg OPENJDK_11_HEADLESS_VERSION="$OPENJDK_11_HEADLESS_VERSION"\
 --build-arg BUILD_PYSPARK_VERSION=""\
 -t loum/pyjdk:python$PYTHON_VERSION-openjdk11\
 -t loum/pyjdk:latest .
