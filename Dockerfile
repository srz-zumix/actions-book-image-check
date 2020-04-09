FROM ubuntu:latest

LABEL maintainer "srz_zumix <https://github.com/srz-zumix>"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update -q -y && \
    apt-get install -y imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
