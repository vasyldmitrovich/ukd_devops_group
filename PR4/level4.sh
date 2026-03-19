#!/bin/bash

# Функція
check_user() {
   echo "Current user: $USER"
}

# Перевірка аргументу (if)
if [ -z "$1" ]; then
    echo "Error: No argument provided."
else
    if [[ "$1" =~ ^[0-9]+$ ]] && [ "$1" -gt 10 ]; then
        echo "Number $1 is greater than 10"
    else
        echo "Argument is not a number or <= 10"
    fi
fi

# Case конструкція
case "$2" in
    start) echo "Starting service..." ;;
    stop)  echo "Stopping service..." ;;
    *)     echo "Usage for second arg: {start|stop}" ;;
esac

# Цикл та масив
SERVERS=("web1" "web2" "db1")
echo "Checking servers:"
for SERVER in "${SERVERS[@]}"; do
    echo " - Server: $SERVER"
done

check_user
