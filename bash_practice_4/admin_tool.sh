#!/bin/bash

# Файли для логів
LOG_FILE="script.log"
ERROR_FILE="errors.log"

# Функція для звіту (report)
get_report() {
    {
        echo "--- СИСТЕМНИЙ ЗВІТ ---"
        echo "Дата: $(date)"
        echo "Hostname: $(hostname)"
        echo "Uptime: $(uptime -p)"
        echo "RAM: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
        echo "Disk: $(df -h / | tail -1 | awk '{print $5}')"
    } >> "$LOG_FILE" 2>> "$ERROR_FILE"
    cat "$LOG_FILE" | tail -n 7
}

# Функція для перевірки диску (disk > 70%)
check_disk() {
    echo "Перевірка розділів (>70%):"
    df -h | awk 'NR>1 {sub(/%/,"",$5); if($5 > 70) print $0}' >> "$LOG_FILE" 2>> "$ERROR_FILE"
}

# Функція для користувачів
list_users() {
    echo "Активні користувачі:"
    who >> "$LOG_FILE" 2>> "$ERROR_FILE"
    who
}

# Головна логіка через Case
case "$1" in
    report)
        get_report
        ;;
    users)
        list_users
        ;;
    disk)
        check_disk
        ;;
    *)
        echo "Використання: $0 {report|users|disk}"
        echo "Помилка: невірний параметр" 2> "$ERROR_FILE"
        exit 1
        ;;
esac
