#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

help() {
    cat << HELP
 Usage: $0 [options...] [db|unit|unit-ci|integrate-local|integrate-ci] [up|down]

 Options
    -h                show this help
HELP
    exit 0
}

while getopts "p:h" OPT
do
    case $OPT in
        h) help ;;
        p) OPT_PROJECT="$OPTARG" ;;
        *) exit ;;
    esac
done

set -eu

shift $(( OPTIND - 1 ));

[ -z "$1" -o -z "$2" ] && help

cd $ROOT_DIR

export COMPOSE_PROJECT_NAME=${OPT_PROJECT:-$$}
case "$1" in
  "db")
    CMD=""
    case "$2" in
      "run")
        docker-compose -f es-base.yml -f es-override-local.yml run wait_for_es ;;
      "down")
        docker-compose -f es-base.yml -f es-override-local.yml down -v;;
    esac
    ;;
  "unit")
    cd $ROOT_DIR/../
    case "$2" in
       "run") npm run test:unit ;;
       "down") echo "noting to do" ;;
    esac
    ;;
  "unit-ci")
    case "$2" in
       "run")
         docker-compose -f unit_test.yml build
         docker-compose -f unit_test.yml run test
         USER_ID=$(id -u) GROUP_ID=$(id -g) docker-compose -f unit_test.yml -f artifact_collector.yml run collect
         USER_ID=$(id -u) GROUP_ID=$(id -g) docker-compose -f unit_test.yml -f artifact_collector.yml down -v ;;
      "down")
         USER_ID=$(id -u) GROUP_ID=$(id -g) docker-compose -f unit_test.yml -f artifact_collector.yml down -v ;;
    esac
    ;;
  "integrate")
    IMAGE_TAG=kuritam/rest-api
    case "$2" in
       "run")
         # up elastic search, and for debug(port publish)
         docker-compose -f es-base.yml -f es-override-local.yml run wait_for_es

         # build and up rest api
         cd $ROOT_DIR/../
         docker build -f Dockerfile.app . -t $IMAGE_TAG
         cd $ROOT_DIR
         RESTAPI_IMAGE=$IMAGE_TAG docker-compose -f es-base.yml -f rest_api-base.yml -f rest_api-override-local.yml run wait_for_restapi

         REST_API_URL="http://localhost:3000" npm run test:integration ;;

      "down")
         RESTAPI_IMAGE=$IMAGE_TAG docker-compose -f es-base.yml -f es-override-local.yml -f rest_api-base.yml -f rest_api-override-local.yml down -v ;;
    esac
    ;;

  "integrate-ci")
    IMAGE_TAG=kuritam/rest-api
    case "$2" in
       "run")
         # up elastic search, port is not published
         docker-compose -f es-base.yml run wait_for_es

         # build and up rest api
         cd $ROOT_DIR/../
         docker build -f Dockerfile.app . -t $IMAGE_TAG
         cd $ROOT_DIR
         RESTAPI_IMAGE=$IMAGE_TAG docker-compose -f es-base.yml -f rest_api-base.yml run wait_for_restapi

         # integration test
         docker-compose -f es-base.yml -f integrate_test.yml build
         RESTAPI_IMAGE=$IMAGE_TAG docker-compose -f es-base.yml -f rest_api-base.yml  -f integrate_test.yml run test
         USER_ID=$(id -u) GROUP_ID=$(id -g) docker-compose -f es-base.yml -f integrate_test.yml -f artifact_collector.yml run collect
         USER_ID=$(id -u) GROUP_ID=$(id -g) RESTAPI_IMAGE=$IMAGE_TAG docker-compose -f es-base.yml -f rest_api-base.yml -f integrate_test.yml -f artifact_collector.yml down -v ;;
      "down")
         USER_ID=$(id -u) GROUP_ID=$(id -g) RESTAPI_IMAGE=$IMAGE_TAG docker-compose -f es-base.yml -f rest_api-base.yml -f integrate_test.yml -f artifact_collector.yml down -v ;;
    esac
      ;;
  *) help ;;
esac
