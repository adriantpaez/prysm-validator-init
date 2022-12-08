#!/bin/bash

# Parse arguments
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

# Import validator keys
CMD="./prism.sh"

if ! [ -z "$CHAIN_CONFIG_FILE" ]; then
    CMD="$CMD --chain-config-file=$CHAIN_CONFIG_FILE"
fi

if ! [ -z "$NETWORK" ]; then
    CMD="$CMD --$NETWORK"
fi

CMD="$CMD accounts import --accept-terms-of-use --keys-dir=/keystore/validator_keys --wallet-dir=/data/wallet --wallet-password-file=/keystore/keystore_password.txt --account-password-file=/keystore/keystore_password.txt"

eval $CMD

# Import slashing protection data
if ! [ -z "$SLASHING_DATA_FILE" ]; then
    echo "Found slashing interchange data in $SLASHING_DATA_FILE"
    echo "Sporting slashing data.."
    ./prysm.sh validator slashing-protection-history import --datadir=/data --slashing-protection-json-file=$SLASHING_DATA_FILE
    echo "Slashing data imported"
fi
