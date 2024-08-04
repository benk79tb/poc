#!/bin/bash

TCPFLOW_PID_FILE="/tmp/tcpflow.pid"

echo $(ip address show eth0 | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1) > /var/log/ip.txt
tcpflow -o /var/log/tcpflow > /var/log/tcpflow.log 2>&1 & echo $! > TCPFLOW_PID_FILE
    # Directory does not exist

    kli init --name "${NAME}" --salt "${SALT}" --nopasscode \
        --config-dir "${CONFIG_DIR}" \
        --config-file "${CONFIG_FILE}"

    kli incept --name ${NAME} --alias ${NAME} --file "${INCEPT_CONFIG_FILE}"

    if [ "$VC_REGISTRY" = "1" ]; then
        echo "Initializing vc registry for ${NAME}"
        kli vc registry incept --name ${NAME} --alias ${NAME} --registry-name ${NAME}-registry
    fi



PREFIX=$(kli status --name ${NAME} --alias ${NAME} | awk '/Identifier:/ {print $2}')
echo $PREFIX > /var/state/prefix/${NAME}





# echo "Starting agent ${NAME}"

# kli agent start --insecure \
#     --config-dir ${CONFIG_DIR} --config-file ${CONFIG_FILE} &
#   PID=$!

# /keri/scripts/demo.sh

WAITING=""
# Boucle infinie pour éviter que le conteneur ne s'arrête
while [ "$WAITING" = "" ]; do
    sleep 1
done