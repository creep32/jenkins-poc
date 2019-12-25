FROM docker:latest

ARG AWS_CLI_VERSION=1.16.309
ARG DOCKER_COMPOSE_VERSION=1.25.0

RUN apk add --no-cache jq
RUN apk add --no-cache py-pip python-dev libffi-dev openssl-dev gcc libc-dev make

RUN pip install --no-cache-dir docker-compose==$DOCKER_COMPOSE_VERSION
RUN pip install --no-cache-dir awscli==$AWS_CLI_VERSION
