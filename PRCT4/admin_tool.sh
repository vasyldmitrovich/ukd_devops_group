#!/bin/bash

# Файли логів
LOG_FILE="script.log"
ERROR_FILE="errors.log"

# Функція для логування подій
log_event() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Функція звіту (report)
get_report() {
    echo "--- СИСТЕМНИЙ ЗВІТ ---"
    echo "Дата: $(date)"
    echo "Хост: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "RAM (Free): $(free -h | grep Mem | awk '{print $4}')"
    echo "Disk usage: $(df -h / | awk 'NR==2 {print $5}')"
    echo "----------------------"
}

# Функція перевірки диску (>70%)
check_disk() {
    echo "Перевірка розділів (>70%):"
    # Цикл по розділах, пропускаючи заголовок
    df -h | grep '^/dev/' | while read -r line; do
        usage=$(echo "$line" | awk '{print $5}' | sed 's/%//')
        partition=$(echo "$line" | awk '{print $1}')
        if [ "$usage" -gt 70 ]; then
            echo "УВАГА: Розділ $partition заповнений на $usage%"
        fi
    done
}

# Головна логіка
case "$1" in
    report)
        get_report
        log_event "Виконано запит звіту"
        ;;
    users)
        echo "Активні користувачі:"
        who
        log_event "Переглянуто список користувачів"
        ;;
    disk)
        check_disk
        log_event "Виконано перевірку диску"
        ;;
    *)
        echo "Використання: $0 {report|users|disk}"
        # Перенаправлення помилки в errors.log
        echo "$(date): Невірний параметр '$1'" >&2 
        log_event "Помилка: невірний параметр"
        exit 1
        ;;
esac 2>> "$ERROR_FILE" # Перенаправлення помилок виконання в окремий файл
