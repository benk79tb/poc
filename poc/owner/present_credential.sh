#!/bin/bash


kli oobi resolve --name ${NAME} --oobi-alias ben \
    --oobi http://witness_3:5631/oobi/${1}/witness/BFyAAOjUcvCJ4Kwz7IP6Ws8ryV5kCjBdI_nKzoHRP98M


echo kli vc present -n ben -a ben --recipient ${1} -s ${2} --include
kli vc present -n ben -a ben --recipient ${1} -s ${2} --include


