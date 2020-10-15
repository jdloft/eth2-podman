#!/bin/sh

cd ~/eth2/$1/node/
NAME=$1-node-0-node

if ! podman ps | grep $NAME ; then
    if podman ps -a | grep $NAME ; then
        podman rm $1-node-0-node
    fi
    podman run \
        --name $1-node-0-node \
        -v ./data/:/data:Z \
        --net=$1 \
        --rm -d gcr.io/prysmaticlabs/prysm/beacon-chain:latest --datadir=/data --rpc-host=0.0.0.0 --grpc-gateway-host=0.0.0.0 --monitoring-host=0.0.0.0 --http-web3provider=https://goerli.prylabs.net --$1
fi
podman logs -f $1-node-0-node

