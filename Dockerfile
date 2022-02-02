FROM ghcr.io/linuxserver/baseimage-alpine:3.15
LABEL maintainer="mdhiggins <mdhiggins23@gmail.com>"

ENV PAS_PATH /usr/local/pas
ENV PAS_UPDATE false

# get python3 and git, and install python libraries
RUN \
  apk add --no-cache \
    git \
    python3 \
    py3-pip && \
# symlink python3 for compatibility
  ln -s /usr/bin/python3 /usr/bin/python && \
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
  apk del --purge && \
  rm -rf \
    /root/.cache \
    /tmp/*

VOLUME /config

# COPY extras/ ${PAS_PATH}/
COPY root/ /
