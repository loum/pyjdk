# PySpark Helper
- [Overview](#Overview)
- [Quick Links](#Quick-Links)
- [Prerequisites](#Prerequisites)
- [Getting Started](#Getting-Started)
- [Getting Help](#Getting-Help)
- [Docker Image Management](#Docker-Image-Management)
  - [Image Build](#Image-Build)
  - [Image Searches](#Image-Searches)
  - [Image Tagging](#Image-Tagging)

## Overview
Quick and easy way to get a PySpark environment with OpenJDK support.

Docker image is based on [Ubuntu Focal 20.04 LTS](https://hub.docker.com/_/ubuntu?tab=description).

## Quick Links
- [PySpark](https://spark.apache.org/docs/latest/api/python/)

## Prerequisites
- [Docker](https://docs.docker.com/install/)
- [GNU make](https://www.gnu.org/software/make/manual/make.html)

## Getting Started
Get the code and change into the top level `git` project directory:
```
git clone https://github.com/loum/pyspark-helper.git && cd pyspark-helper
```
> **_NOTE:_** Run all commands from the top-level directory of the `git` repository.

For first-time setup, prime the [Makester project](https://github.com/loum/makester.git):
```
git submodule update --init
```
Keep [Makester project](https://github.com/loum/makester.git) up-to-date with:
```
make submodule-update
```
Setup the environment:
```
make init
```
## Getting Help
There should be a `make` target to get most things done.  Check the help for more information:
```
make help
```
## Docker Image Management
### Image Build
When you are ready to build the image:
```
make build-image
```
### Image Searches
Search for existing Docker image tags with command:
```
make search-image
```
### Image Tagging
By default, `makester` will tag the new Docker image with the current branch hash.  This provides a degree of uniqueness but is not very intuitive.  That's where the `tag-version` `Makefile` target can help.  To apply tag as per project tagging convention `<PYSPARK_VERSION>-<MAKESTER__RELEASE-NUMBER>`
```
make tag-version
```
To tag the image as `latest`
```
make tag-latest
```
- MapReduce JobHistory Server web UI: http://localhost:19888

---
[top](#PySpark-Helper)
