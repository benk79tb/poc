#!/bin/bash

# echo "owner ready" >> /var/state/owner

kli oobi resolve --name ${NAME} --oobi-alias ${NAME} \
    --oobi ${WAN_WITNESS_URL}/oobi/${RICHARD_PREFIX}/witness/${WAN_PREFIX}
