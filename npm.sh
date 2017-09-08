#!/bin/bash -ex

BASE_DIR=$(dirname $0)
cd ${BASE_DIR}

# include utility
. ./script/_utility.sh

check_cmd docker-compose

docker-compose -f docker/docker-compose.yml run npm ${@+"$@"}
exit $?
