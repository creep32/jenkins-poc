#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

cd $ROOT_DIR

cat  ../VERSION | tr -d '\n'

exit 0
