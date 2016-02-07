#!/usr/bin/sh

if [ "$1" = "--debug" ] || [ "$1" = "-d" ]; then
    export DEBUG_MODE=1
    shift
fi

if [ -n "${DEBUG_MODE}" ]; then
    export PS4='+ [${BASH_SOURCE##*/} : ${LINENO}] '
    set -x
fi

echo ${DEBUG_MODE}

# variables
TEMP_DIR="/tmp/$$"
