#!/bin/bash


RECEIVED_CRED=""

while [ "$RECEIVED_CRED" = "" ]; do
    sleep 1
    
    check_prefix=$(kli vc list --name ben --poll | grep "Swiss ID")
    if [ "$check_prefix" != "" ]; then
        check_prefix=$(kli vc list --name ben --said)
        RECEIVED_CRED=$check_prefix
    fi
done

echo $RECEIVED_CRED