#!/bin/bash

# Визначаємо ціль для перевірки (localhost за замовчуванням або аргумент)
TARGET=${1:-"localhost"}

# Функція для перевірки стану Apache
check_apache() {
    echo "----------------------------"
    echo "Checking host: $TARGET"
    
    # 1. Перевірка чи встановлено (використовуємо command -v як сучасну альтернативу which)
    if command -v apache2 >/dev/null 2>&1; then
        echo "Apache: installed"
    else
        echo "Apache: not installed"
        return 1 # Виходимо з функції, якщо не встановлено
    fi

    # 2. Перевірка чи процес запущений
    if ps aux | grep "[a]pache2" >/dev/null 2>&1; then
        echo "Apache: running"
    else
        echo "Apache: not running"
    fi
}

# Функція для перевірки доступності сайту через curl
check_site() {
    # Виконуємо запит та отримуємо тільки HTTP код
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET" 2>/dev/null)

    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo "Website: $HTTP_STATUS OK"
    elif [ "$HTTP_STATUS" -eq 000 ]; then
        echo "Website: not reachable"
    else
        echo "Website: status $HTTP_STATUS"
    fi
    echo "----------------------------"
}

# Виклик функцій
check_apache
check_site
