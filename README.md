## Gomspace AVR32 toolchain

This repository contains the scripts needed to build the AVR32 toolchain with GomSpace modifications.
It is based on the work done by https://github.com/embecosm/avr32-toolchain

### Repository structure:

  scripts/
    avr32-clone-all.sh   <- Clone the dependencies
    avr32-versions.sh    <- Defines the branches for the dependencies
    build-all.sh         <- The script that build the toolchain
    Dockerfile           <- Dockerfile used to build docker image used for toolchain building

### Cloning dependencies:

Clone this repo to your computer. Then cd into the root of this repo and run:

  ./scripts/avr32-clone-all.sh

This will clone all the required dependencies

### Building the toolchain:

The toolchain is built inside a docker container. To create the docker container run this command:

  docker build scripts/ -t toolchainbuild

When the container is ready, the toolchain can be built like this:

  docker run --rm -v `pwd`:/home/toolbuild -w /home/toolbuild/scripts -t toolchainbuild ./build-all.sh

After 10-15 minutes a new version of the toolchain is available as: 
``avr32-gnu-toolchain-<version>.<patchlevel>-linux.any.x86_64.tar.gz.``
Version and patchlevel is set by the build-all.sh script.

There is also a file called:
``gs-avr32-toolchain-<version>.tar.gz``
This file contains the built toolchain, header files for avr32, the programmer tool and install script

### Modifying newlib:

If your modifications to newlib contains changes to the build system, you shall re-generate the autotool files. 
From the root of the toolchain directory from above, run the command:

  docker run --rm -v `pwd`:/home/toolbuild -w /home/toolbuild/newlib/newlib -t toolchainbuild autoreconf2.64
