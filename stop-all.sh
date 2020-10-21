#!/bin/sh

if [ -z "$1" ]; then
    echo "No network provided"
    exit 1
fi

function stop() {
    if podman ps | grep $1 ; then
        podman stop $1
    fi
}

stop $1-node-0-node
stop $1-validator-0-validator
stop $1-slasher-0-slasher

