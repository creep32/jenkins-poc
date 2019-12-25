#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

set -eu

cd $ROOT_DIR

TAG=kuritam/jenkins-operation

docker build . -t $TAG
docker push $TAG
