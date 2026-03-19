#!/bin/bash

LOG="script.log"
ERR="errors.log"

# Записуємо час запуску в лог
echo "=== Запуск admin_tool.sh (PID: $$) о $(date) ===" >> "$LOG"

show_report() {
    echo "--- System Report ---"
    echo "Date: $(date)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "RAM Usage:"
    free -h
    echo "Disk Usage:"
    df -h /
}

show_users() {
    echo "--- Active Users ---"
    who
}

if [ -z "$1" ]; then
    echo "Помилка: Не передано параметр! Використовуйте: report, users або disk" | tee -a "$ERR" >&2
    exit 1
fi

case "$1" in
    report)
        show_report 2>> "$ERR" | tee -a "$LOG"
        ;;
        
    users)
        show_users 2>> "$ERR" | tee -a "$LOG"
        ;;
        
    disk)
        echo "--- Перевірка дисків (>70%) ---" | tee -a "$LOG"
        df -h | grep -v "Use%" | while read line; do
            # Витягуємо відсоток і назву розділу
            USAGE=$(echo $line | awk '{print $5}' | sed 's/%//')
            PARTITION=$(echo $line | awk '{print $1}')
            
            if [ "$USAGE" -ge 70 ] 2>/dev/null; then
                echo "УВАГА: Розділ $PARTITION заповнений на $USAGE%!" | tee -a "$LOG"
            fi
        done
        ;;
        
    *)
        echo "Помилка: Невідомий параметр '$1'" >> "$ERR"
        echo "Доступні параметри: report, users, disk"
        ;;
esac
