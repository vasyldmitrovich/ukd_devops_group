#!/bin/bash

HOST="${1:-localhost}"

echo "Checking host: $HOST"
check_apache() {
    if which apache2 > /dev/null 2>&1; then
        echo "Apache: installed"
        
        if ps aux | grep -v grep | grep -q apache2; then
            echo "Apache: running"
        else
            echo "Apache: not running"
        fi
    else
        echo "Apache: not installed"
    fi
}

check_site() {
    HTTP_CODE=$(curl -s -L -o /dev/null -w "%{http_code}" --max-time 5 "http://$HOST")

    if [ "$HTTP_CODE" = "000" ] || [ -z "$HTTP_CODE" ]; then
        echo "Website: not reachable"
    else
        echo "HTTP status: $HTTP_CODE"
    fi
}

check_apache
check_site
