#!/bin/sh

if [ -z "$1" ]; then
    echo "No network provided"
    exit 1
fi

cd ~/eth2/$1/validator/
podman run \
    --name $1-exit-0-exit \
    -v ./passwords/:/passwords:ro,Z \
    -v ./wallet/:/wallet:Z \
    --net=$1 \
    --rm -it gcr.io/prysmaticlabs/prysm/validator:latest accounts-v2 voluntary-exit --wallet-dir=/wallet --wallet-password-file=/passwords/wallet-pass.txt --beacon-rpc-provider $1-node-0-node:4000 --$1

