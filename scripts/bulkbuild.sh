#!/bin/sh

for PYTHON_VERSION in 3.8 3.9 3.10
do
    docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=loum/python3-ubuntu:jammy-$PYTHON_VERSION\
 --build-arg OPENJDK_11_HEADLESS_VERSION=11.0.17+8-1ubuntu2~22.04\
 --build-arg BUILD_PYSPARK_VERSION=""\
 -t loum/pyjdk:python$PYTHON_VERSION-openjdk11 .
done

# Latest.
for PYTHON_VERSION in 3.11
do
    docker buildx build --platform linux/arm64,linux/amd64\
 --push --rm --no-cache\
 --build-arg UBUNTU_BASE_IMAGE=loum/python3-ubuntu:jammy-$PYTHON_VERSION\
 --build-arg OPENJDK_11_HEADLESS_VERSION=11.0.17+8-1ubuntu2~22.04\
 --build-arg BUILD_PYSPARK_VERSION=""\
 -t loum/pyjdk:python$PYTHON_VERSION-openjdk11\
 -t loum/pyjdk:latest .
done
