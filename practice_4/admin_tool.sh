#!/bin/bash

LOG_FILE="script.log"
ERR_LOG="error.log"

generate_report() {
    echo "=== System Report [$(date)] ==="
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "RAM (Free/Total): $(free -h | grep Mem | awk '{print $4 "/" $2}')"
    echo "Disk Usage (/): $(df -h / | tail -1 | awk '{print $5}')"
}

check_disk_usage() {
    echo "=== Disk Usage Check (>70%) ==="
        mapfile -t partitions < <(df -h | grep '^/dev/')
    
    for line in "${partitions[@]}"; do
        usage=$(echo "$line" | awk '{print $5}' | sed 's/%//')
        path=$(echo "$line" | awk '{print $1}')
        
        if [ "$usage" -gt 70 ]; then
            echo "Warning: Partition $path is at ${usage}%!"
	else
	    echo  "Partition $path ($mount_point) usage is normal: ${usage}%."
        fi
    done
}

if [ $# -eq 0 ]; then
    echo "Usage: $0 {report|users|disk}" | tee -a "$LOG_FILE"
    exit 1
fi

case "$1" in
    report)
        generate_report >> "$LOG_FILE" 2>> "$ERR_LOG"
        generate_report
        ;;
    users)
        echo "=== Active Users ===" >> "$LOG_FILE" 2>> "$ERR_LOG"
        who >> "$LOG_FILE" 2>> "$ERR_LOG"
        who
        ;;
    disk)
        check_disk_usage >> "$LOG_FILE" 2>> "$ERR_LOG"
        check_disk_usage
        ;;
    *)
        echo "Error: Unknown parameter '$1'" >> "$ERR_LOG"
        echo "Valid parameters: report, users, disk"
        exit 1
        ;;
esac
