#!/bin/bash

# Визначаємо хост для перевірки: або аргумент $1, або за замовчуванням localhost
TARGET=${1:-localhost}

echo "Checking host: $TARGET"

# Функція 1: Перевірка самого сервісу Apache (тільки якщо перевіряємо localhost)
check_apache() {
    if [ "$TARGET" == "localhost" ]; then
        # Перевірка чи встановлений
        if which apache2 > /dev/null 2>&1; then
            echo "Apache: installed"
            
            # Перевірка чи запущений процес
            if ps aux | grep -v grep | grep -q apache2; then
                echo "Apache: running"
            else
                echo "Apache: not running"
            fi
        else
            echo "Apache: not installed"
        fi
    else
        echo "Remote check: skipping local Apache process check."
    fi
}

# Функція 2: Перевірка доступності сайту через HTTP код
check_site() {
    # Використовуємо curl для отримання тільки HTTP коду
    # -s (silent), -o /dev/null (не виводити тіло сайту), -w (вивести формат)
    STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET")

    if [ "$STATUS_CODE" -eq 200 ]; then
        echo "Website: $STATUS_CODE OK"
    elif [ "$STATUS_CODE" -eq 000 ]; then
        echo "Website: not reachable"
    else
        echo "Website: status $STATUS_CODE"
    fi
}

# Запуск функцій
echo "--------------------------"
check_apache
check_site
echo "--------------------------"
