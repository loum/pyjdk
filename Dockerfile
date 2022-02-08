ARG UBUNTU_BASE_IMAGE
FROM ubuntu:$UBUNTU_BASE_IMAGE

ARG OPENJDK_11_HEADLESS
ARG PYTHON3_RELEASE
ARG PYTHON3_PIP
RUN apt-get update && apt-get install -y --no-install-recommends\
 make\
 python3.8-venv\
 python3.8=$PYTHON3_RELEASE\
 python3-pip=$PYTHON3_PIP\
 python-is-python3\
 openjdk-11-jdk-headless=$OPENJDK_11_HEADLESS &&\
 rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD [ "python3" ]
