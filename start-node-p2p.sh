#!/bin/sh

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "No network or P2P ports provided"
    exit 1
fi

cd eth2/$1/node/
NAME=$1-node-0-node

if ! podman ps | grep $NAME ; then
    if podman ps -a | grep $NAME ; then
        podman rm $NAME
    fi
    podman run \
        --name $NAME \
        -v ./data/:/data:Z \
        -p 0.0.0.0:$2:$2 \
        -p 0.0.0.0:$3:$3 \
        --net=$1 \
        --rm -d gcr.io/prysmaticlabs/prysm/beacon-chain:latest --accept-terms-of-use --datadir=/data --rpc-host=0.0.0.0 --grpc-gateway-host=0.0.0.0 --monitoring-host=0.0.0.0 --http-web3provider=https://goerli.prylabs.net --$1 --p2p-host-ip=$(curl -s v4.ident.me) --p2p-udp-port $2 --p2p-tcp-port $3
fi
podman logs -f $1-node-0-node

