#!/bin/bash

HOST=${1:-"localhost"}

echo "Checking host: $HOST"

check_apache() {
    if which apache2 > /dev/null 2>&1; then
        echo "Apache: installed"
        if ps aux | grep "[a]pache2" > /dev/null; then
            echo "Apache: running"
        else
            echo "Apache: not running"
        fi
    else
        echo "Apache: not installed"
    fi
}

check_site() {
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://$HOST")
    if [ "$STATUS" -eq 200 ]; then
        echo "Website: 200 OK"
    elif [ "$STATUS" -eq 000 ]; then
        echo "Website: not reachable"
    else
        echo "Website: status $STATUS"
    fi
}

check_apache
check_site
