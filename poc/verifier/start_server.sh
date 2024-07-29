#!/bin/bash

function waitfor() {
  # Utility function wrapper for the wait-for script
  # Passes all arguments passed to this function through to the wait-for script with "$@"
  # See https://github.com/eficode/wait-for
  /keri/scripts/wait-for "$@"
}


echo "Waiting issuer prefix"
ISSUER_PREFIX=""


  sally hook demo > /var/log/sally_hook.log &
  COP_WEBHOOK_PID=$!
  waitfor localhost:9923 -t 1

while [ "$ISSUER_PREFIX" = "" ]; do
    sleep 1
    check_prefix=$(cat /var/state/prefix/valais)
    if [ "$check_prefix" != "" ]; then
        check_prefix=$(cat /var/state/prefix/valais | tr -d '[:space:]')
        ISSUER_PREFIX=$check_prefix
    fi
done

echo "Issuer prefix: $ISSUER_PREFIX"
  sally server start --name cop --alias cop \
    --web-hook http://127.0.0.1:9923 \
    --auth "${ISSUER_PREFIX}" > /var/log/sally.log &
  SALLY_PID=$!

  echo sally server start --name cop --alias cop \
    --web-hook http://127.0.0.1:9923 \
    --auth "${ISSUER_PREFIX}"

  echo "SALLY_PID: $SALLY_PID"
#   sally server start --name cop --alias cop \
#     --web-hook http://127.0.0.1:9923 \
#     --auth "${WISEMAN_PREFIX}" \
#     --schema-mappings "${SCHEMA_MAPPING_FILE}" &
#   SALLY_PID=$!
  waitfor localhost:9723 -t 2

  echo "server started"
