#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

docker-compose -f docker-compose.yml -f docker-compose-local.yml down



