#!/bin/bash

# Змінна для цілі (localhost за замовчуванням або аргумент $1)
TARGET=${1:-"localhost"}

echo "Checking host: $TARGET"

# Функція 1: Перевірка наявності та стану Apache
check_apache() {
    # Перевіряємо чи встановлено (which повертає 0 якщо знайдено)
    if which apache2 > /dev/null 2>&1; then
        echo "Apache: installed"
        
        # Перевіряємо чи запущений процес
        if ps aux | grep "[a]pache2" > /dev/null; then
            echo "Apache: running"
        else
            echo "Apache: not running"
        fi
    else
        echo "Apache: not installed"
    fi
}

# Функція 2: Перевірка доступності сайту через HTTP статус
check_site() {
    # Використовуємо curl для отримання лише коду відповіді
    # -s (silent), -o /dev/null (не виводити тіло сайту), -w (формат виводу)
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://$TARGET")

    if [ "$STATUS" -eq 200 ]; then
        echo "Website: $STATUS OK"
    elif [ "$STATUS" -eq 000 ]; then
        echo "Website: not reachable"
    else
        echo "Website: status $STATUS"
    fi
}

# Виклик функцій
check_apache
check_site
