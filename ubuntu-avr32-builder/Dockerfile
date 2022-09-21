FROM ubuntu:18.04


RUN apt-get update && apt-get install -y \
    automake1.11 \
    autoconf2.64 \
    bison \
    flex \
    git \
    libgmp-dev \
    libmpfr-dev \
    libprotobuf-dev \
    lsb-release \
    ncurses-dev \
    pkg-config \
    protobuf-compiler \
    python \
    python-six \
    python-pint \
    python-pip \
    python-protobuf \
    python-bson \
    python-jsonschema \
    wget


# Build and install old version of texinfo
# Otherwise the build will fail with texi errors
RUN wget http://ftp.gnu.org/gnu/texinfo/texinfo-4.13.tar.gz && \
    tar xf texinfo-4.13.tar.gz && \
    cd texinfo-4.13 && \
    ./configure && \
    make && \
    make install

RUN pip install --upgrade pip
