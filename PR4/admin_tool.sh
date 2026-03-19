#!/bin/bash

# Файли логів
LOG_FILE="script.log"
ERR_FILE="errors.log"

# Функція для звіту
get_report() {
    echo "--- System Report ($(date)) ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "RAM: $(free -h | grep Mem | awk '{print $3 "/" $2}')"
    echo "Disk: $(df -h / | awk 'NR==2 {print $5}') usage"
}

# Функція для перевірки диска (>70%)
check_disk() {
    echo "Checking partitions with >70% usage:"
    df -h | awk '{ if($5+0 > 70) print $0 }'
}

# Основна логіка
ACTION=$1

case "$ACTION" in
    report)
        get_report >> "$LOG_FILE" 2>> "$ERR_FILE"
        get_report
        ;;
    users)
        echo "Active users:" | tee -a "$LOG_FILE"
        who >> "$LOG_FILE" 2>> "$ERR_FILE"
        who
        ;;
    disk)
        check_disk >> "$LOG_FILE" 2>> "$ERR_FILE"
        check_disk
        ;;
    *)
        echo "Usage: $0 {report|users|disk}"
        exit 1
        ;;
esac
