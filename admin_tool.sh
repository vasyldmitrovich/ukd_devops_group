#!/bin/bash

LOG="script.log"
ERR="errors.log"

get_report() {
    {
        echo "--- REPORT $(date) ---"
        echo "Hostname: $(hostname)"
        echo "Uptime: $(uptime -p)"
        echo "RAM usage:"
        free -h
        echo "Disk usage:"
        df -h | grep '^/dev/'
    } >> "$LOG" 2>> "$ERR"
}

check_disk() {
    echo "Перевірка розділів (>70%):" >> "$LOG"
    df -h | awk '0+$5 > 70 {print $0}' >> "$LOG" 2>> "$ERR"
}

case "$1" in
    report)
        get_report
        echo "Звіт готовий у файлі $LOG"
        ;;
    users)
        echo "Активні користувачі на $(date):" >> "$LOG"
        who >> "$LOG"
        ;;
    disk)
        check_disk
        echo "Перевірка диска записана в $LOG"
        ;;
    *)
        echo "Використання: $0 {report|users|disk}"
        exit 1
        ;;
esac
