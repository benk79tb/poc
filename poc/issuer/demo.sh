#!/bin/bash

echo "issuer ready" >> /var/state/issuer

# function waitloop() {
#   logwaiting "${LTGRN}Control-C${EC} to exit (will shut down witnesses, agents, and Gatekeeper  if started, and will clear .keri and .sally)"
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
#   while [ "$OWNER_PREFIX" -e "" ]; do
#     sleep 1


#     check_prefix=cat /var/state/prefix/ben
#     if [ "$check_prefix" -ne "" ]; then
#       OWNER_PREFIX=$check_prefix
#     fi
#   done
# }

cat /keri/scripts/credential_data.json
echo "Owner prefix: $OWNER_PREFIX"


    # "http://witness_1:5631/oobi/BBilc4-L3tFUnfM_wJr4S4OJanAv_VmF_dJNN6vkf2Ha",

  kli oobi resolve --name ${NAME} --oobi-alias ben \
    --oobi http://witness_2:5631/oobi/${OWNER_PREFIX}/witness/BA5Vo4mWJWz4ou3lFqerCUNjwzPcg8my4cSumFAN062w


# kli oobi resolve --name valais --oobi http://witness_1:5631/oobi/EPbZAE095gFes8iZwbV3M7cVOtSra6Qrq2kHmWrhNbyg/witness/BBilc4-L3tFUnfM_wJr4S4OJanAv_VmF_dJNN6vkf2Ha


# kli oobi resolve --name ${NAME} --alias ${NAME} --registry-name ${NAME}-registry \
#     --schema "EEYMNgyQNHWrsO4m65Px84M93o2url6aUpTFqNdMZdKt" \
#     --recipient "${OWNER_PREFIX}" \
#     --data @/keri/scripts/credential_data.json

kli vc issue --name ${NAME} --alias ${NAME} --registry-name ${NAME}-registry \
    --schema "EEYMNgyQNHWrsO4m65Px84M93o2url6aUpTFqNdMZdKt" \
    --recipient "${OWNER_PREFIX}" \
    --data @/keri/scripts/credential_data.json

