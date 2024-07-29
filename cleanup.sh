#!/bin/bash

echo "Cleaning up data"

cleanup() {
    local name=$1
    # echo "Cleaning up ${name}"
    # kli agent stop --config-dir ${CONFIG_DIR} --config-file ${CONFIG_FILE}
    
    local keriDir="data/${name}/keri"
    if [[ -d $keriDir ]]; then
        # echo rm -rf $keriDir/*
        rm -rf $keriDir/*
    fi
    # rm -rf $name/keri/*


    local prefFile="poc/state/prefix/${name}"
    if [[ -f $prefFile ]]; then
        rm $prefFile
    fi
}

cleanup ben
cleanup cop
cleanup valais
cleanup witness_1
cleanup witness_2
cleanup witness_3
# rm -rf /usr/local/var/keri/*
# rm .initialized
# rm /var/state/prefix/${NAME}

