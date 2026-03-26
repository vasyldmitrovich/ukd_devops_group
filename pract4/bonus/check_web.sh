#!/bin/bash

# Змінна для хоста
TARGET=${1:-"localhost"}

echo "--- Checking host: $TARGET ---"

#Функція перевірки Apache
check_apache() {
    # Перевіряємо чи встановлено
    if which apache2 > /dev/null 2>&1; then
        echo "Apache: installed"
        
        # Перевіряємо чи запущений процес
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
    # Використовуємо curl для отримання HTTP коду
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET" || echo "failed")

    if [ "$STATUS" == "200" ]; then
        echo "Website: 200 OK"
    elif [ "$STATUS" == "failed" ]; then
        echo "Website: not reachable"
    else
        echo "Website: status $STATUS"
    fi
}

# Виклик функцій
check_apache
check_site
