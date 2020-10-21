#!/bin/sh

if [ -z "$1" ]; then
    echo "No network provided"
    exit 1
fi

cd ~/eth2/$1/slasher/
NAME=$1-slasher-0-slasher

if ! podman ps | grep $NAME ; then
    if podman ps -a | grep $NAME ; then
        podman rm $NAME
    fi
    podman run \
        --name $NAME \
        -v ./data/:/data:Z \
        --net=$1 \
        --rm -d gcr.io/prysmaticlabs/prysm/slasher:latest --accept-terms-of-use --datadir=/data --beacon-rpc-provider $1-node-0-node:4000 --$1
fi
podman logs -f $1-slasher-0-slasher

