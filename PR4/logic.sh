#!/bin/bash

# 1. Перевірка аргументу
if [ -z "$1" ]; then
    echo "Error: Please provide a number!"
    exit 1
fi

# 2. Перевірка чи число > 10
if [ "$1" -gt 10 ]; then
    echo "Number $1 is greater than 10"
else
    echo "Number $1 is 10 or less"
fi

# 3. Цикл по масиву
SERVERS=("web1" "web2" "db1")
echo "Checking infrastructure:"
for S in "${SERVERS[@]}"; do
    echo " - Status of $S: Online"
done
