#!/bin/bash

# Файли для логування
LOG="script.log"
ERR_LOG="errors.log"

get_report() {
    echo "--- REPORT: $(date) ---"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "RAM Usage:"
    free -h
    echo "Disk Usage:"
    df -h | grep '^/dev/'
}

check_disk() {
    echo "--- High Disk Usage Check ---"
    # Використовуємо цикл для проходу по розділах
    df -h | grep '^/dev/' | while read line; do
        # Витягуємо відсоток (5-та колонка)
        usage=$(echo $line | awk '{print $5}' | sed 's/%//')
        partition=$(echo $line | awk '{print $1}')
        
        if [ "$usage" -gt 70 ]; then
            echo "WARNING: Partition $partition is at ${usage}%!"
        else
            echo "Partition $partition is OK (${usage}%)."
        fi
    done
}

ACTION=$1

case "$ACTION" in
    report)
        get_report >> "$LOG" 2>> "$ERR_LOG"
        echo "Report generated in $LOG"
        ;;
    users)
        echo "--- Active Users ($(date)) ---" >> "$LOG"
        who >> "$LOG" 2>> "$ERR_LOG"
        echo "User list updated in $LOG"
        ;;
    disk)
        check_disk >> "$LOG" 2>> "$ERR_LOG"
        echo "Disk check completed. See $LOG"
        ;;
    "")
        # Якщо аргумент порожній (умова if)
        echo "Error: No argument provided!" >&2
        echo "$(date): Attempted run without arguments" >> "$ERR_LOG"
        echo "Usage: $0 {report|users|disk}"
        exit 1
        ;;
    *)
        # Всі інші випадки
        echo "Error: Invalid parameter '$ACTION'" >&2
        echo "$(date): Invalid param '$ACTION'" >> "$ERR_LOG"
        exit 1
        ;;
esac
