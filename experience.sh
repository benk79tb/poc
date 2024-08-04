#!/bin/bash



log() {
    local current_time=$(date +"%Y-%m-%d %H:%M:%S.%6N")
    echo "$current_time    $1" >> ./data/experience.log
}

shutdown() {
    docker compose down
    # ./cleanup.sh
    exit 0
}

trap shutdown SIGINT

get_prefix() {
    local name=$1
    local prefix=""
    while [ "$prefix" = "" ]; do
        sleep 1
        check_prefix=$(cat ./poc/state/prefix/${name} 2>/dev/null)
        if [ "$check_prefix" != "" ]; then
            check_prefix=$(cat ./poc/state/prefix/${name} | tr -d '[:space:]')
            prefix=$check_prefix
        fi
    done
    echo $prefix
}

wait_file_exists() {

    local name=$1

    while [ ! -f "$name" ]; do
        sleep 1
    done
}

wait_experience_done() {
    local file="data/cop/log/sally.log"

    while [ ! -f "$file" ]; do
        sleep 1
    done

    local done=""
    while [ "$done" = "" ]; do
        sleep 1
        done=$(cat $file | grep "Valid credential")
    done
    log "${done}"
    echo $done
}



###############################################################################

log "Cleaning up data"
./cleanup.sh
log "Data cleaned up"

log "Starting docker compose"
docker compose up --build -d
log "Docker compose started"
# docker compose up -d

# docker compose build --no-cache
# docker compose up -d


SEPARATOR="---------------------"

log "waiting for actors to be ready"
OWNER_PREFIX=$(get_prefix ben)
ISSUER_PREFIX=$(get_prefix valais)
VERIFIER_PREFIX=$(get_prefix cop)
log "Actors are ready"


# echo "Owner prefix: $OWNER_PREFIX"
# echo "Issuer prefix: $ISSUER_PREFIX"
# echo "Verifier prefix: $VERIFIER_PREFIX"

# ./analyze_start.sh

sleep 5
echo "All actors are ready"


echo $SEPARATOR
echo "Issuing credential:"
echo ""

log "Issuing credential"
result=$(docker exec -it poc-issuer-1 ./scripts/issue.sh $OWNER_PREFIX)
log "Credential issued"

echo "$result"
echo $SEPARATOR


sleep 2
echo $SEPARATOR
echo "Receiving credential:"
echo ""

log "Receiving credential"
result=$(docker exec -it poc-owner-1 ./scripts/receive_credential.sh)
log "Credential received"
RECEIVED_CRED=$(echo "$result" | tail -n 1)
echo "$result"
echo $SEPARATOR

sleep 2
echo $SEPARATOR
echo "Presenting credential:"
echo ""

log "Presenting credential"
result=$(docker exec -it poc-owner-1 ./scripts/present_credential.sh $VERIFIER_PREFIX $RECEIVED_CRED)
log "Credential presented"
echo "$result"
echo $SEPARATOR


echo $SEPARATOR

echo "Verifying credential:"
log "Verifying credential"
# echo "Check data/cop/log/sally.log to view verification status."
# echo "Press Ctrl+C to stop when you are done."


# WAITING=""
# while [ "$WAITING" = "" ]; do
#     sleep 1
# done

wait_experience_done
# log "Credential verified"
echo $SEPARATOR
echo "Credential verified"
log "Experience done"

echo "Shutting down..."
shutdown

# docker compose down
# docker exec -it poc-issuer-1 bash
