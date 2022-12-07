#!/bin/bash

SLASHING_DATA_FILE=$1

if [ -f "$SLASHING_DATA_FILE" ]; then
    echo "Found slashing interchange data in $SLASHING_DATA_FILE"
    echo "Sporting slashing data.."
    ./prysm.sh validator slashing-protection-history import --datadir=/data --slashing-protection-json-file=$SLASHING_DATA_FILE
    echo "Slashing data imported"
fi
