FROM python:3
MAINTAINER Alexander Paul <alex.paul@.wustl.edu>

LABEL \
  description="ExpansionHunterDenvo image for use in Workflows(https://github.com/Illumina/ExpansionHunterDenovo)"

RUN apt-get update && apt-get install -y \
  cmake \
  git \
  g++ \
  libboost-all-dev \
  libbz2-dev \
  liblzma-dev \
  ncurses-dev \
  pip3 \
  unzip \
  wget \
  zlib1g-dev

WORKDIR /opt
RUN wget https://github.com/Kitware/CMake/releases/download/v3.15.3/cmake-3.15.3-Linux-x86_64.tar.gz -O cmake.tar.gz \
  && tar -zxvf cmake.tar.gz \
  && mv cmake-3.15.3-Linux-x86_64 cmake

ENV EXPANSION_HUNTER_INSTALL_DIR=/opt/ExpansionHunterDenovo
ENV EXPANSION_HUNTER_VERSION=0.8.0
ENV EXPANSION_HUNTER_COMMIT="361faadab1f9de2208a8cfd5494877226b99c3d7"

RUN wget https://github.com/Illumina/ExpansionHunterDenovo/archive/${EXPANSION_HUNTER_COMMIT}.zip \
  && unzip ${EXPANSION_HUNTER_COMMIT}.zip \
  && mv ExpansionHunterDenovo-${EXPANSION_HUNTER_COMMIT} ExpansionHunterDenovo \
  && cd ExpansionHunterDenovo/ \
  && mkdir build && cd build \
  && /opt/cmake/bin/cmake -DCMAKE_BUILD_TYPE=Release ../source \
  && make

RUN pip3 install scipy

WORKDIR /
