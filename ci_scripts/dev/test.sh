#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

cd $ROOT_DIR/../

set -eu

docker-compose build
docker-compose -f docker-compose.yml run --rm lint ansible-lint --force-color playbook.yml

echo "no lint error."

exit 0
