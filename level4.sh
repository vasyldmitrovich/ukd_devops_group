#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: No argument provided"
  exit 1
fi

if [ "$1" -gt 10 ]; then
  echo "Number > 10"
else
  echo "Number <= 10"
fi

case "$2" in
  start) echo "Starting..." ;;
  stop) echo "Stopping..." ;;
  status) echo "Status..." ;;
  *) echo "Unknown command" ;;
esac

echo "Numbers 1 to 5:"
for i in {1..5}
do
  echo $i
done

SERVERS=("web1" "web2" "db1")
for server in "${SERVERS[@]}"
do
  echo "Server: $server"
done

check_user() {
  echo "Current user: $USER"
}

check_user
