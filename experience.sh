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


sleep 5
echo "All actors are ready"
log "Actors are ready"


echo $SEPARATOR
echo "Issuing credential:"
echo ""

log "Issuing credential"
sleep 1
result=$(docker exec -it poc-issuer-1 ./scripts/issue.sh $OWNER_PREFIX)
sleep 5
log "Credential issued"

echo "$result"
echo $SEPARATOR


echo $SEPARATOR
echo "Receiving credential:"
echo ""

log "Receiving credential"
sleep 1
result=$(docker exec -it poc-owner-1 ./scripts/receive_credential.sh)
sleep 5
log "Credential received"
RECEIVED_CRED=$(echo "$result" | tail -n 1)
echo "$result"
echo $SEPARATOR

echo $SEPARATOR
echo "Presenting credential:"
echo ""

log "Presenting credential"
sleep 2
result=$(docker exec -it poc-owner-1 ./scripts/present_credential.sh $VERIFIER_PREFIX $RECEIVED_CRED)
sleep 5
log "Credential presented"
echo "$result"
echo $SEPARATOR


echo $SEPARATOR

echo "Verifying credential:"
log "Verifying credential"
sleep 2
wait_experience_done
echo $SEPARATOR
sleep 5
echo "Credential verified"

echo $SEPARATOR
echo "Waiting 5min before shutting down"
log "No actions started"
sleep 300
log "No actions finished"
log "Experience done"

echo "Shutting down..."
shutdown

