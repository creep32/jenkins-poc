#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

ecs-cli compose --file docker-compose.yml  \
  -p kuri-api \
  -r ap-southeast-1 \
  create

