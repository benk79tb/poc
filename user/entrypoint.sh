#!/bin/bash

if [ ! -f ".initialized" ]; then

    # Directory does not exist

    kli init --name "${NAME}" --salt "${SALT}" --nopasscode \
        --config-dir "${CONFIG_DIR}" \
        --config-file "${CONFIG_FILE}"

    kli incept --name ${NAME} --alias ${NAME} --file "${INCEPT_CONFIG_FILE}"

    if [ "$VC_REGISTRY" = "1" ]; then
        echo "Initializing vc registry for ${NAME}"
        kli vc registry incept --name ${NAME} --alias ${NAME} --registry-name ${NAME}-registry
    fi

    echo "initialized" > .initialized
fi


PREFIX=$(kli status --name ${NAME} --alias ${NAME} | awk '/Identifier:/ {print $2}')
echo $PREFIX > /var/state/prefix/${NAME}


echo "Starting agent ${NAME}"

kli agent start --insecure \
    --config-dir ${CONFIG_DIR} --config-file ${CONFIG_FILE} &
  PID=$!

/keri/scripts/demo.sh
