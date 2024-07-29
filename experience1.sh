#!/bin/bash
./cleanup.sh
# docker compose up --build -d
# docker compose up -d

docker compose build --no-cache
docker compose up -d


SEPARATOR="---------------------"

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

OWNER_PREFIX=$(get_prefix ben)
ISSUER_PREFIX=$(get_prefix valais)
VERIFIER_PREFIX=$(get_prefix cop)


# echo "Owner prefix: $OWNER_PREFIX"
# echo "Issuer prefix: $ISSUER_PREFIX"
# echo "Verifier prefix: $VERIFIER_PREFIX"

echo "All actors are ready"


echo $SEPARATOR
echo "Issuing credential:"
echo ""

result=$(docker exec -it poc-issuer-1 ./scripts/issue.sh $OWNER_PREFIX)
echo "$result"
echo $SEPARATOR


echo $SEPARATOR
echo "Receiving credential:"
echo ""

result=$(docker exec -it poc-owner-1 ./scripts/receive_credential.sh)
RECEIVED_CRED=$(echo "$result" | tail -n 1)
echo "$result"
echo $SEPARATOR


echo $SEPARATOR
echo "Presenting credential:"
echo ""

result=$(docker exec -it poc-owner-1 ./scripts/present_credential.sh $VERIFIER_PREFIX $RECEIVED_CRED)
echo "$result"
echo $SEPARATOR

# docker compose down
# docker exec -it poc-issuer-1 bash
