# Python3 and OpenJDK on Ubuntu

- [Overview](#overview)
- [Quick links](#quick-links)
- [Prerequisites](#prerequisites)
- [Getting started](#getting-started)
  - [(macOS users only) upgrading GNU Make](#macos-users-only-upgrading-gnu-make)
  - [Creating the local environment](#creating-the-local-environment)
- [Help](#help)
- [Docker image development and management](#docker-image-development-and-management)
  - [Building the image](#building-the-image)
  - [Searching images](#searching-images)
  - [Image tagging](#image-tagging)
  - [Building the image with a different Python 3 version](#building-the-image-with-a-different-python-3-version)
- [Interact with the `loum/pyjdk` image](#interact-with-the-loumpyjdk-image)

## Overview

This repository manages the customised Docker image build of Python3 on Ubuntu. You can target any Python 3 verions against any Ubuntu release. Just follow the `makester` settings below.

Bypassing the [Docker Hub Official Image Python](https://hub.docker.com/_/python%3E) image build is much more work, but gives us more flexibility to address CVEs.

The image build process is based on [GitHub Python project's Docker build](https://github.com/docker-library/python/blob/e0e01b8482ea14352c710134329cdd93ece88317/3.8/buster/slim/Dockerfile) with a switch to Ubuntu base. Not sure why there isn't a Ubuntu variant available in the [Official Python images](https://hub.docker.com/_/python)?

## Quick links

- [Ubuntu](https://ubuntu.com/)
- [Python 3](https://www.python.org/)

## Prerequisites

- [GNU make](https://www.gnu.org/software/make/manual/make.html)
- Python 3 Interpreter. [We recommend installing pyenv](https://github.com/pyenv/pyenv)
- [Docker](https://www.docker.com/)
- [Makester project](https://github.com/loum/makester.git)

## Getting started

[Makester](https://loum.github.io/makester/) is used as the Integrated Developer Platform.

### (macOS users only) upgrading GNU Make

Follow [these notes](https://loum.github.io/makester/macos/#upgrading-gnu-make-macos) to get [GNU make](https://www.gnu.org/software/make/manual/make.html).

### Creating the local environment

Get the code and change into the top level `git` project directory:

```
git clone https://github.com/loum/pyjdk.git && cd pyjdk
```

> [!NOTE]
>
> Run all commands from the top-level directory of the `git` repository.

## Help

There should be a `make` target to be able to get most things done. Check the help for more information:

```
make help
```

## Docker image development and management

### Building the image

> **_NOTE:_** Ubuntu base image is [noble 24.04](https://hub.docker.com/_/ubuntu)

Build the image with:

```
make image-buildx
```

### Searching images

To list the available Docker images::

```
make image-search
```

### Image tagging

By default, `makester` will tag the new Docker image with the current branch hash. This provides a degree of uniqueness but is not very intuitive. That is where the `image-tag-version` `Makefile` target can help. To apply tag as per project tagging convention `<ubuntu-code>-<python3-version>-<image-release-number>`:

```
make image-tag-version
```

Sample output:

```
### Tagging container image "loum/pyjdk" as "python3.10-openjdk11-1"
```

To tag the image as `latest`

```
make image-tag-latest
```

Sample output:

```
### Tagging container image "loum/pyjdk" as "latest"
```

To tag the image main line (without the `<image-release-number>` that ensures the latest Ubuntu release:

```
make image-tag-main
```

Sample output:

```
### Tagging container image "loum/pyjdk" as "python3.10-openjdk11"
```

### Building the image with a different Python 3 version

During the image build, a fresh compile of the Python binaries is performed. In theory, any Python release under https://www.python.org/ftp/python/ can be used. You will need to supply the `PYTHON_MAJOR_MINOR_VERSION` to the image build target. For example, to build an image with the latest Python 3.9:

```
PYTHON_MAJOR_MINOR_VERSION=3.9 make image-buildx
```

To validate the image runs as expected:

```
make container-run
```

By default, the `container-run` target will drop you into the Python REPL:

```
Python 3.9.16 (main, Jan 29 2023, 10:42:18)
[GCC 11.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

On success this will drop you into the Python interpreter.

## Interact with the `loum/pyjdk` image

The `container-run` target is a convenience action that will drop into the Python REPL of the current image build:

```
make container-run
```

To get the container image Python version:

```
make container-run CMD=--version
```

> **_NOTE:_** Override the `CMD` variable to pass any CLI options to the Python executable.

### PySpark REPL

PySpark is not installed by default. This is to keep the image size as small as possible. However, the environment is ready to support a PySpark install. `loum/pyjdk` can serve as a base image for your larger project. If you only want a quick and simple PySpark REPL, then provide a PySpark version to the `BUILD_PYSPARK_VERSION` environment variable:

```
BUILD_PYSPARK_VERSION=3.3.1 m container-run
```

Without a `CMD`, this will drop you into the PySpark REPL:

```
Successfully installed py4j-0.10.9.5 pyspark-3.3.1
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 3.3.1
      /_/

Using Scala version 2.12.15, OpenJDK 64-Bit Server VM, 11.0.17
Branch HEAD
Compiled by user yumwang on 2022-10-15T09:47:01Z
Revision fbbcf9434ac070dd4ced4fb9efe32899c6db12a9
Url https://github.com/apache/spark
Type --help for more information.
```

______________________________________________________________________

[top](#python3-and-openjdk-on-ubuntu)
