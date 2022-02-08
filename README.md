# PySpark Helper
- [Overview](#Overview)
- [Quick Links](#Quick-Links)
- [Prequisites](#Prerequisites)
  - [Upgrading GNU Make (macOS)](#Upgrading-GNU-Make-(macOS))
- [Getting Started](#Getting-Started)
  - [Building the Local Environment](#Building-the-Local-Environment)
    - [Local Environment Maintenance](#Local-Environment-Maintenance)
- [Help](#Help)
- [Docker Image Development and Management](#Docker-Image-Development-and-Management)
  - [Building the Docker Image](#Building-the-Docker-Image)
  - [Searching Images](#Searching-Images)
  - [Image Tagging](#Image-Tagging)
- [FAQs](#FAQs)

## Overview
This repository is primarily used to build a vanilla base Docker image for further install of PySpark.  That is, it gives you Python3 and a JVM ready for a PySpark install.  How you do that is completely up to you.  But you probably want to do it as non-`root` and in a Python virtual environment and/or as a less privileged user.

## Quick Links
- [Ubuntu](https://ubuntu.com/)
- [Python](https://www.python.org/)

## Prerequisties
- [Docker](https://docs.docker.com/install/)
- [GNU make](<https://www.gnu.org/software/make/manual/make.html>)

### Upgrading GNU Make (macOS)
Although the macOS machines provide a working GNU `make` it is too old to support the capabilities within the DevOps utilities 
package, [makester](https://github.com/loum/makester).  Instead, it is recommended to upgrade to the GNU make version provided 
by Homebrew.  Detailed instructions can be found at https://formulae.brew.sh/formula/make.  In short, to upgrade GNU make run:
```
brew install make
```
The `make` utility installed by Homebrew can be accessed by `gmake`.  The https://formulae.brew.sh/formula/make notes suggest how you can update your local `PATH` to use `gmake` as `make`.  Alternatively, alias `make`:
```
alias make=gmake
```
## Getting Started
### Building the Local Environment
Get the code and change into the top level `git` project directory:
```
git clone https://github.com/loum/pyspark-helper.git && cd pyspark-helper
```
For first-time setup, get the [Makester project](https://github.com/loum/makester.git):
```
git submodule update --init
```
Initialise the environment:
```
make init
```
#### Local Environment Maintenance
Keep [Makester project](https://github.com/loum/makester.git) up-to-date with:
```
git submodule update --remote --merge
```
## Help
There should be a `make` target to be able to get most things done.  Check the help for more information:
```
make help
```
## Docker Image Development and Management
### Building the Image
> **_NOTE:_** Ubuntu base image used is [focal 20.04](https://hub.docker.com/_/ubuntu)

Build the image with:
```
make build-image
```
### Searching Images
To list the available Docker images::
```
make search-image
```
### Image Tagging
By default, `makester` will tag the new Docker image with the current branch hash.  This provides a degree of uniqueness but is not very intuitive.  That's where the `tag-version` `Makefile` target can help.  To apply tag as per project tagging convention `<python3-version>-<openjdk-version>-<image-release-number>`:
```
make tag-version
```
To tag the image as `latest`
```
make tag-latest
```
To tag the image main line (without the `<image-release-number>` that ensures the latest Ubuntu focal release:
```
make tag-main
```
## Interact with PySpark Helper Image
Remember, this is just a basic, vanilla Python3/OpenJDK image.  There are some basic commands that you can run in isolation.  To get the Python3 version:
```
make python-version
```
To start the Python3 interpreter:
```
make python
```
## FAQs
**_Q. Why is the default make on macOS so old?_**
Apple seems to have an issue with licensing around GNU products: more specifically to the terms of the GPLv3 license agreement. It is unlikely that Apple will provide current versions of utilities that are bound by the GPLv3 licensing constraints.

---
[top](#PySpark-Helper)
