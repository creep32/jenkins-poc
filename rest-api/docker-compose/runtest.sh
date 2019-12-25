#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

[ -z "$1" ] && echo "usage> $0 [unit|integrate]"

docker-compose -f docker-compose.yml -f docker-compose-local.yml -f docker-compose-test.yml run $1


