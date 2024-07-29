#!/bin/bash


kli oobi resolve --name ${NAME} --oobi-alias ben \
    --oobi http://witness_2:5631/oobi/${1}/witness/BA5Vo4mWJWz4ou3lFqerCUNjwzPcg8my4cSumFAN062w


kli vc issue --name ${NAME} --alias ${NAME} --registry-name ${NAME}-registry \
    --schema "EEYMNgyQNHWrsO4m65Px84M93o2url6aUpTFqNdMZdKt" \
    --recipient "${1}" \
    --data @/keri/scripts/credential_data.json

