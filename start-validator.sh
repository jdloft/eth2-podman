#!/bin/sh

cd ~/eth2/$1/validator/
NAME=$1-validator-0-validator

if ! podman ps | grep $NAME ; then
    if podman ps -a | grep $NAME ; then
        podman rm $NAME
    fi
    podman run \
        --name $NAME \
        -v ./passwords/:/passwords:ro,Z \
        -v ./wallet/:/wallet:Z \
        -v ./db/:/db:Z \
        --net=$1 \
        --rm -d gcr.io/prysmaticlabs/prysm/validator:latest --wallet-dir=/wallet --wallet-password-file=/passwords/wallet-pass.txt --datadir=/db --beacon-rpc-provider $1-node-0-node:4000 --monitoring-host=0.0.0.0 --$1 --graffiti=jdloft
fi
podman logs -f $1-validator-0-validator

