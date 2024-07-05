#!/bin/bash

# echo "owner ready" >> /var/state/owner


echo "Waiting verifier prefix"
VERIFIER_PREFIX=""

while [ "$VERIFIER_PREFIX" = "" ]; do
    sleep 1
    check_prefix=$(cat /var/state/prefix/cop)
    if [ "$check_prefix" != "" ]; then
        check_prefix=$(cat /var/state/prefix/cop | tr -d '[:space:]')
        VERIFIER_PREFIX=$check_prefix
    fi
done

# kli oobi resolve --name ${NAME} --oobi-alias ${NAME} \
#     --oobi ${WAN_WITNESS_URL}/oobi/${VERIFIER_PREFIX}/witness/${WAN_PREFIX}
kli oobi resolve --name ${NAME} --oobi-alias ben \
    --oobi http://witness_2:5631/oobi/${VERIFIER_PREFIX}/witness/BA5Vo4mWJWz4ou3lFqerCUNjwzPcg8my4cSumFAN062w


RECEIVED_CRED=""

while [ "$RECEIVED_CRED" = "" ]; do
    sleep 1
    
    check_prefix=$(kli vc list --name ben --poll | grep "Swiss ID")
    if [ "$check_prefix" != "" ]; then
        check_prefix=$(kli vc list --name ben --said)
        RECEIVED_CRED=$check_prefix
    fi
done


kli vc present -n ben -a ben --recipient ${VERIFIER_PREFIX} -s ${RECEIVED_CRED} --include