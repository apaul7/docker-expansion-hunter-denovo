FROM python:3
MAINTAINER Alexander Paul <alex.paul@.wustl.edu>

LABEL \
  description="ExpansionHunterDenvo image for use in Workflows(https://github.com/Illumina/ExpansionHunterDenovo)"

RUN apt-get update && apt-get install -y \
  wget

WORKDIR /opt

ENV EXPANSION_HUNTER_VERSION=0.8.0

RUN wget https://github.com/Illumina/ExpansionHunterDenovo/releases/download/v${EXPANSION_HUNTER_VERSION}/ExpansionHunterDenovo-v${EXPANSION_HUNTER_VERSION}-linux_x86_64.tar.gz \
  && tar -zxvf ExpansionHunterDenovo-v${EXPANSION_HUNTER_VERSION}-linux_x86_64.tar.gz \
  && mv ExpansionHunterDenovo-v${EXPANSION_HUNTER_VERSION}-linux_x86_64 ExpansionHunterDenovo \
  && mv ExpansionHunterDenovo/bin/ExpansionHunterDenovo-v${EXPANSION_HUNTER_VERSION} ExpansionHunterDenovo/bin/ExpansionHunterDenovo \
  && ln -s /opt/ExpansionHunterDenovo/bin/ExpansionHunterDenovo /usr/bin/ \
  && rm ExpansionHunterDenovo-v${EXPANSION_HUNTER_VERSION}-linux_x86_64.tar.gz

RUN pip3 install scipy

WORKDIR /
