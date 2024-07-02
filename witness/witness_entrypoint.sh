#!/bin/bash

# printenv

if [ ! -f ".initialized" ]; then

    # Initialize the witness

    echo "Initializing witness ${NAME}"
    echo kli init --name "${NAME}" --salt "${SALT}" --nopasscode \
        --config-dir "${CONFIG_DIR}" \
        --config-file "main/${CONFIG_FILE}"
    kli init --name "${NAME}" --salt "${SALT}" --nopasscode \
        --config-dir "${CONFIG_DIR}" \
        --config-file "main/${CONFIG_FILE}"
    echo "Initialized witness ${NAME}"

    echo "Initialized" > .initialized
fi

# Start the witness

echo "Starting witness ${NAME}"
# echo kli witness start --name "${NAME}" --alias "${NAME}"
echo "started" > .started


KERIPY_VERSION=$(kli version)

# if [[ "${KERIPY_VERSION}" == "1.0.0" ]]; then
#     kli witness start --name "${NAME}" --alias "${NAME}"
# else
    echo kli witness start --name "${NAME}" --alias "${NAME}" --config-dir "${CONFIG_DIR}" \
        --config-file "${CONFIG_FILE}"
    kli witness start --name "${NAME}" --alias "${NAME}" --config-dir "${CONFIG_DIR}" \
        --config-file "${CONFIG_FILE}"
# fi
# kli witness start --name "${NAME}" --alias "${NAME}" --config-dir "${CONFIG_DIR}" \
#         --config-file "${CONFIG_FILE}"

# kli witness start --name "${NAME}" --alias "${NAME}" --config-dir "${CONFIG_DIR}" \
#         --config-file "${CONFIG_FILE}"





# kli witness start --name "${NAME}" --alias "${NAME}" \
#     -T ${WAN_WITNESS_TCP_PORT} \
#     -H ${WAN_WITNESS_HTTP_PORT} \
#     --config-dir "${CONFIG_DIR}" \
#     --config-file wan-witness 
    
