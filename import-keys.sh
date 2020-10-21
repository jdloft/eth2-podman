#!/bin/sh

if [ -z "$1" ]; then
    echo "No network provided"
    exit 1
fi

cd ~/eth2/$1/validator/
podman run \
    --name $1-import-keys \
    -v ./passwords/:/passwords:ro,Z \
    -v ./wallet/:/wallet:Z \
    -v ./keys/:/keys:ro,Z \
    --net=none \
    --rm gcr.io/prysmaticlabs/prysm/validator:latest accounts import --keys-dir=/keys --wallet-dir=/wallet --wallet-password-file=/passwords/wallet-pass.txt --account-password-file=/passwords/account-pass.txt --$1

