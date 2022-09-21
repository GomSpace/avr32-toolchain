# AVR32 GNU Tool Chain

This is the main git repository for the Atmel AVR 32-bit GNU tool chain. It contains
just the scripts required to build the entire tool chain.

There are various branches of this repository which will automatically build
complete tool chains for various releases. This is the version for the
3.4.2 tool chain development branches.

When run, the build script will check out the appropriate branches for each of
the relevant tool chain component repositories.

## Prequisites

You will need a Linux like environment with docker installed.


## Building The Toolchain

The `buildall` script clones the various GNU gcc, binutils and newlib source
repos and then builds everything from source.

The repos referenced are the original GNU sources but with Atmel patches
already applied.

Because we are working with ancient code here, a modern Linux will have
trouble building it without installing some pretty old versions of texinfo,
automake and autoconf.

This is the reason we build everything inside a docker container.
The docker container then runs the `buildall` script.

In brief, build with:

```commandline
    ./buildall clone
    ./runincontainer
```

The `./buildall clone` step clones the repos we need. It takes a while.
It needs to be done outside the container to avoid issues with git/ssh
credentials and permissions.

## Original Source Archives

  - [https://ww1.microchip.com/downloads/en/DeviceDoc/atmel-headers-6.1.3.1475.zip](https://ww1.microchip.com/downloads/en/DeviceDoc/atmel-headers-6.1.3.1475.zip)


## Other Projects

* [embecosm/avr32-toolchain: Scripts for building and testing the AVR 32-bit GNU tool chain](https://github.com/embecosm/avr32-toolchain)
  was the original work which the previous version of
  [GomSpace/avr32-toolchain](https://github.com/GomSpace/avr32-toolchain)
  was based on.
* [kuhlix/avr32-toolchain](https://github.com/kuhlix/avr32-toolchain)
  is one of many forks of original repo in
  [jsnyder/avr32-toolchain: Makefile & supporting patches/scripts to build an AVR32 toolchain.](https://github.com/jsnyder/avr32-toolchain)
  - It seems to be the most maintained of all the forks
  - It uses a Makefile to build everything from sources and has various fixes
    for building on fairly recent gcc versions and recent distributions.
  - The Makefile is pretty readable and not too big. It downloads the gcc
    toolchain sources and the avr32 patches from the atmel.com.
    Then the sources are  patched and everything is built.
  - Some download URLs work and some don't.


## Other Resources

* [AVR32 compiler - MAV'RIC Library](http://lis-epfl.github.io/MAVRIC_Library/Toolchain/AVR32_compiler.html)
  is a page about the avr32 toolchain, how to get it and build it. It refers to
  [lis-epfl/avr32-toolchain](https://github.com/denravonska/avr32-toolchain)
  for building on MacOS and that repo which is another clone of aforementioned
  *jsnyder/avr32-toolchain* repo.

## Other information

The standard Atmel download is provided as patch files against the standard
GNU tool chain distributions. `SOURCES.README` describes these files,
`build-avr32-gnu-toolchain.sh` is the script to build from these sources. The
patch files themselves may be found in the patches directory.

The script `patchbuild.sh` is used to apply the patches as git commits,
creating appropriate ChangeLog.AVR32 entries. The git repository includes all
these commits.
