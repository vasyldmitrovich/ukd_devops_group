#!/bin/bash

check_user() {
    echo "Current user: $USER"
}

if [ -z "$1" ]; then
    echo "Error: No argument provided! (Enter a number after the script name)"
else
    if [ "$1" -gt 10 ] 2>/dev/null; then
        echo "Result: Number $1 is greater than 10."
    else
        echo "Result: Argument $1 is not a number greater than 10."
    fi
fi

echo "--------------------------"

ACTION=$2
case "$ACTION" in
    start)
        echo "Action: Starting service..."
        ;;
    stop)
        echo "Action: Stopping service..."
        ;;
    status)
        echo "Action: Checking status..."
        ;;
    *)
        echo "Action: Unknown operation (try start, stop or status)"
        ;;
esac

echo "--------------------------"

echo "Loop from 1 to 5:"
for i in {1..5}; do
    echo "Number: $i"
done

SERVERS=("web1" "web2" "db1")
echo "Iterating through server array:"
for SERVER in "${SERVERS[@]}"; do
    echo "Connecting to: $SERVER..."
done

echo "--------------------------"

check_user