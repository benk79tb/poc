#!/bin/bash


kli oobi resolve --name ${NAME} --oobi-alias ben \
    --oobi http://witness_2:5631/oobi/${1}/witness/BA5Vo4mWJWz4ou3lFqerCUNjwzPcg8my4cSumFAN062w


echo kli vc present -n ben -a ben --recipient ${1} -s ${2} --include
kli vc present -n ben -a ben --recipient ${1} -s ${2} --include


