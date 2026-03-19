#!/bin/bash

HOSTS=("localhost" "google.com")

check_apache() {
    if which apache2 > /dev/null 2>&1; then
        echo "Apache: installed"
    else
        echo "Apache: not installed"
    fi

    if ps aux | grep -v grep | grep apache2 > /dev/null 2>&1; then
        echo "Apache: running"
    else
        echo "Apache: not running"
    fi
}

check_site() {
    local HOST=$1

    HTTP_CODE=$(curl -s -L -o /dev/null -w "%{http_code}" http://$HOST)

    if [ "$HTTP_CODE" -eq 200 ]; then
        echo "$HOST: HTTP status: 200 OK"
    else
        echo "$HOST: HTTP status: $HTTP_CODE (not reachable)"
    fi
}

echo "Checking Apache..."
check_apache
echo "------------------------"

for HOST in "${HOSTS[@]}"; do
    echo "Checking site: $HOST"
    check_site "$HOST"
    echo "------------------------"
done
