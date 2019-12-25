#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

docker-compose -f docker-compose.yml -f docker-compose-local.yml run wait_es
docker-compose -f docker-compose.yml -f docker-compose-local.yml build restapi
docker-compose -f docker-compose.yml -f docker-compose-local.yml run wait_restapi



