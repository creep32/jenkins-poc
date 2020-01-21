#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

cd $ROOT_DIR/../

set -eu

DP_PASSWORD=$(aws secretsmanager get-secret-value --secret-id  dev/zansible-sample | jq . | jq -r .SecretString | jq -r .DbPassword)
BASE64_ENCODED_PEM=$(aws secretsmanager get-secret-value --secret-id  dev/zansible-sample | jq -r .SecretString | jq -r .Base64EncodedPem)

echo $BASE64_ENCODED_PEM | base64 -d > ../id_rsa.pem
chmod 600 ../id_rsa.pem
docker-compose build
docker-compose -f docker-compose.yml run --rm  ansible ansible-playbook -i dev-hosts playbook.yml -e "DB_PASSWORD=$DP_PASSWORD" $*
#docker-compose -f docker-compose.yml run ansible ls -la

exit 0
