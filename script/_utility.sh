#!/bin/bash -e

exist_arg1() {
    local EXIST_ARG1=false
    if [ "$1" ]; then
        local EXIST_ARG1=true
    fi
    echo ${EXIST_ARG1}
}

check_cmd() {
    if [ $(exist_arg1 $(which $1)) = "false" ]; then
        cat <<__EOT__
You must install $1
__EOT__
        exit 1
    fi
}
