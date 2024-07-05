#!/bin/bash

if [ ! -f ".initialized" ]; then

    # Initialize the witness

    echo "Initializing witness ${NAME}"

    kli init --name "${NAME}" --salt "${SALT}" --nopasscode \
        --config-dir "${CONFIG_DIR}" \
        --config-file "main/${CONFIG_FILE}"

    echo "Initialized witness ${NAME}"

    echo "Initialized" > .initialized
fi





# tcpflow -p -c -i eth0 port 5631 > /tmp/tcpflow.log & echo $! > /tmp/tcpflow.pid
tcpflow -p -c -i eth0 port 5631 & echo $! > /tmp/tcpflow.pid


# Start the witness

echo "Starting witness ${NAME}"

echo "Starting witness ${NAME}" > .started
kli witness start --name "${NAME}" --alias "${NAME}" --config-dir "${CONFIG_DIR}" \
    --config-file "${CONFIG_FILE}"
