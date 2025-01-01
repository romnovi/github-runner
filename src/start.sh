#!/bin/bash

ORG=$ORG
NAME=$NAME
ACCESS_TOKEN=$ACCESS_TOKEN
REG_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/orgs/${ORG}/actions/runners/registration-token | jq -r '.token')

cd /home/docker/actions-runner || exit
./config.sh --url https://github.com/${ORG} --token ${REG_TOKEN} --name ${NAME}

cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
