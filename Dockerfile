FROM ghcr.io/linuxserver/baseimage-mono:LTS
LABEL maintainer="mdhiggins <mdhiggins23@gmail.com>"

ENV PAS_PATH /usr/local/pas
ENV PAS_UPDATE false

# get python3 and git, and install python libraries
RUN \
  apt-get update && \
  apt-get install -y \
    git \
    python3 \
    python3-pip && \
# make directory
  mkdir ${PAS_PATH} && \
# download repo
  git clone https://github.com/mdhiggins/PlexAutoSkip.git ${PAS_PATH} && \
# install pip, venv, and set up a virtual self contained python environment
  python3 -m pip install --user --upgrade pip && \
  python3 -m pip install --user virtualenv && \
  python3 -m virtualenv ${PAS_PATH}/venv && \
  ${PAS_PATH}/venv/bin/pip install -r ${PAS_PATH}/setup/requirements.txt && \
# link config
  ln -s /config ${PAS_PATH}/config && \
# cleanup
  apt-get purge --auto-remove -y && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

VOLUME /config

# COPY extras/ ${PAS_PATH}/
COPY root/ /
