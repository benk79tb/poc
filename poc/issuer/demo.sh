#!/bin/bash

echo "Waiting owner prefix"
OWNER_PREFIX=""

while [ "$OWNER_PREFIX" = "" ]; do
    sleep 1
    check_prefix=$(cat /var/state/prefix/ben)
    if [ "$check_prefix" != "" ]; then
        check_prefix=$(cat /var/state/prefix/ben | tr -d '[:space:]')
        OWNER_PREFIX=$check_prefix
    fi
done

cat /keri/scripts/credential_data.json
echo "Owner prefix: $OWNER_PREFIX"


kli oobi resolve --name ${NAME} --oobi-alias ben \
    --oobi http://witness_2:5631/oobi/${OWNER_PREFIX}/witness/BA5Vo4mWJWz4ou3lFqerCUNjwzPcg8my4cSumFAN062w


kli vc issue --name ${NAME} --alias ${NAME} --registry-name ${NAME}-registry \
    --schema "EEYMNgyQNHWrsO4m65Px84M93o2url6aUpTFqNdMZdKt" \
    --recipient "${OWNER_PREFIX}" \
    --data @/keri/scripts/credential_data.json

