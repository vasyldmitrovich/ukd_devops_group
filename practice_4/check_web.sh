#!/bin/bash

TARGET=${1:-"localhost"}

check_apache() {
    echo "Checking service: apache2"
    
    if command -v apache2 >/dev/null 2>&1; then
        echo "Apache: installed"
    else
        echo "Apache: not installed"
        return 1
    fi

    if ps aux | grep "[a]pache2" >/dev/null 2>&1; then
        echo "Apache: running"
    else
        echo "Apache: not running"
    fi
}

check_site() {
    echo "Checking host: $TARGET"
    
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET")
    
    if [ "$STATUS" -eq 200 ]; then
        echo "Website: $STATUS OK"
    elif [ "$STATUS" -eq 000 ]; then
        echo "Website: not reachable"
    else
        echo "Website: $STATUS (other status)"
    fi
}

echo "--------------------------"
check_apache
echo "--------------------------"
check_site
echo "--------------------------"
