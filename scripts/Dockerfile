FROM ubuntu:16.04


RUN apt-get update && apt-get install -y \
    python \
    git \
    python-six \
    pkg-config \
    python-pint \
    python-pip \
    libprotobuf-dev \
    protobuf-compiler \
    python-protobuf \
    python-bson \
    python-jsonschema \
    automake1.11 \
    autoconf2.64 \
    bison \
    flex \
    ncurses-dev \
    wget \
    libmpfr-dev \
    libgmp-dev

# Build and Install old version of texinfo
RUN wget http://ftp.gnu.org/gnu/texinfo/texinfo-4.13.tar.gz && tar xf texinfo-4.13.tar.gz && cd texinfo-4.13 && ./configure && make && make install

RUN pip install --upgrade pip