#!/bin/bash

# printenv


if [ ! -f ".initialized" ]; then
    # Directory does not exist

    echo kli init --name "${NAME}" --salt "${SALT}" --nopasscode
    kli init --name "${NAME}" --salt "${SALT}" --nopasscode

    kli oobi resolve --name "${NAME}" --oobi "http://witness_1:5631/oobi/BBilc4-L3tFUnfM_wJr4S4OJanAv_VmF_dJNN6vkf2Ha"
    kli oobi resolve --name "${NAME}" --oobi "http://witness_2:5631/oobi/BA5Vo4mWJWz4ou3lFqerCUNjwzPcg8my4cSumFAN062w"
    kli oobi resolve --name "${NAME}" --oobi "http://witness_3:5631/oobi/BFyAAOjUcvCJ4Kwz7IP6Ws8ryV5kCjBdI_nKzoHRP98M"
    kli oobi resolve --name "${NAME}" --oobi "http://chgov:7723/oobi/EEYMNgyQNHWrsO4m65Px84M93o2url6aUpTFqNdMZdKt"

    echo kli incept --name ${NAME} --alias ${NAME} --file "${INCEPT_CONFIG_FILE}"
    kli incept --name ${NAME} --alias ${NAME} --file "${INCEPT_CONFIG_FILE}"


    if [ "$VC_REGISTRY" = "1" ]; then
        echo "Initializing vc registry for ${NAME}"
        kli vc registry incept --name ${NAME} --alias ${NAME} --registry-name ${NAME}-registry
    fi

    echo "initialized" > .initialized
fi


echo "Starting agent ${NAME}"
# kli agent start --insecure \
#     --config-dir ${CONFIG_DIR} --config-file ${CONFIG_FILE} \
#     --path /agent_static/

echo kli agent start --insecure \
    --config-dir ${CONFIG_DIR} --config-file ${CONFIG_FILE}

kli agent start --insecure \
    --config-dir ${CONFIG_DIR} --config-file ${CONFIG_FILE}



# kli start --name "${NAME}" --alias "${NAME}" --config-dir "${CONFIG_DIR}" --config-file "${CONFIG_FILE}"

# kli witness start --name "${NAME}" --alias "${NAME}"


