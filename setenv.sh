#!/bin/bash

# SOURCE: https://github.com/homeops/services/blob/master/setenv.sh

source ./secrets/env.sh

stack_name="${PWD##*/}"

DC_VERSION="3.5"

alias stackup="docker stack deploy -c ./docker-compose.yml ${stack_name}"
alias stackdown="docker stack rm ${stack_name}"
