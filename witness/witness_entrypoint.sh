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


# Start the witness

echo "Starting witness ${NAME}"

kli witness start --name "${NAME}" --alias "${NAME}" --config-dir "${CONFIG_DIR}" \
    --config-file "${CONFIG_FILE}"
