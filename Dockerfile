# syntax=docker/dockerfile:1.4

ARG UBUNTU_BASE_IMAGE
ARG OPENJDK_11_HEADLESS_VERSION
ARG BUILD_PYSPARK_VERSION

FROM $UBUNTU_BASE_IMAGE AS main

USER root

ARG OPENJDK_11_HEADLESS_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends\
 git\
 gcc\
 ssh\
 python3-dev\
 openjdk-11-jdk-headless=$OPENJDK_11_HEADLESS_VERSION &&\
 apt-get autoremove -yqq --purge &&\
 rm -rf /var/lib/apt/lists/*

ARG BUILD_PYSPARK_VERSION
ENV PYSPARK_VERSION=$BUILD_PYSPARK_VERSION

# "user" is taken from the base image.
COPY --chown=user:user scripts/bootstrap.sh /bootstrap.sh

WORKDIR /home/user
USER user

ENTRYPOINT [ "/bootstrap.sh" ]
CMD []
