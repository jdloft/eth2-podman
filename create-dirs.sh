#!/bin/sh

if [ -z "$1" ]; then
    echo "No network provided"
    exit 1
fi

mkdir -p eth2/$1/{node/data,validator/passwords,validator/wallet,validator/db}

