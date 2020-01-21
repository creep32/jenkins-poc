#!/usr/bin/env bash

ROOT_DIR=$( cd $( dirname ${BASH_SOURCE:-$0} ) && pwd )

cd $ROOT_DIR/../

set -eu
DP_PASSWORD=$(aws secretsmanager get-secret-value --secret-id  dev/sansible-sample | jq . | jq -r .SecretString | jq -r .DB_PASSWWORD)
BASE64_ENCODED_PEM=$(aws secretsmanager get-secret-value --secret-id  dev/sansible-sample | jq -r .SecretString | jq -r .BASE64_ENCODED)

echo $BASE64_ENCODED_PEM | base64 -d > ../id_rd_rsa.pem
docker-compose build
docker-compose -f docker-compose.yml run ansible ansible-playbook -i dev-hosts playbook.yml -e "DB_PASSWORD=$DP_PASSWORD"

exit 0
