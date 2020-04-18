FROM debian:buster-slim

LABEL "com.github.actions.name"="TF Helper Action"
LABEL "com.github.actions.description"="Run commands with Hashicorps TF helper in Github Actions"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="green"

LABEL version="0.0.2"
LABEL repository="https://github.com/mirrorweb/tf-helper-action"
LABEL maintainer="Mark Johnson <mark.johnson@mirrorweb.com>"


RUN apt-get update && apt-get install -y git curl jq && \
    rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/hashicorp-community/tf-helper.git
RUN ln -s /tf-helper/tfh/bin/tfh /usr/local/bin/tfh

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
