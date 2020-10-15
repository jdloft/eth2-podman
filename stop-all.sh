#!/bin/sh

if [ -z "$1" ]; then
    echo "No network provided"
    exit 1
fi

podman stop $1-node-0-node
podman stop $1-validator-0-validator
podman stop $1-slasher-0-slasher

