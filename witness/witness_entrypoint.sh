#!/bin/bash
TCPFLOW_PID_FILE="/tmp/tcpflow.pid"
stop() {
    if [ -f "${TCPFLOW_PID_FILE}" ]; then
        kill -2 $(cat "${TCPFLOW_PID_FILE}")
        rm -f "${TCPFLOW_PID_FILE}"
    fi
}

trap stop SIGINT SIGTERM SIGKILL EXIT

    # Initialize the witness

    echo "Initializing witness ${NAME}"

    kli init --name "${NAME}" --salt "${SALT}" --nopasscode \
        --config-dir "${CONFIG_DIR}" \
        --config-file "main/${CONFIG_FILE}"

    echo "Initialized witness ${NAME}"




echo $(ip address show eth0 | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1) > /var/log/ip.txt
tcpflow -o /var/log/tcpflow > /var/log/tcpflow.log 2>&1 & echo $! > TCPFLOW_PID_FILE


# Start the witness

echo "Starting witness ${NAME}"

echo "Starting witness ${NAME}" > .started
kli witness start --name "${NAME}" --alias "${NAME}" --config-dir "${CONFIG_DIR}" \
    --config-file "${CONFIG_FILE}"
