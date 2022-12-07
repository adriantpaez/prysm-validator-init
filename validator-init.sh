#!/bin/bash

# Imprt validator keys
./prysm.sh accounts import \
    --accept-terms-of-use \
    --keys-dir=/keystore/validator_keys \
    --wallet-dir=/data/wallet \
    --wallet-password-file=/keystore/keystore_password.txt \
    --account-password-file=/keystore/keystore_password.txt

# Import slashing protection data
SLASHING_DATA_FILE=$1

if [ -f "$SLASHING_DATA_FILE" ]; then
    echo "Found slashing interchange data in $SLASHING_DATA_FILE"
    echo "Sporting slashing data.."
    ./prysm.sh validator slashing-protection-history import --datadir=/data --slashing-protection-json-file=$SLASHING_DATA_FILE
    echo "Slashing data imported"
fi
