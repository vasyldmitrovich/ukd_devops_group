#!/bin/bash

LOG="script.log"
ERROR_LOG="errors.log"

log() {
  echo "$(date) - $1" >> $LOG
}

report() {
  echo "=== REPORT ==="
  date
  hostname
  uptime
  free -h
  df -h
}

users() {
  echo "=== USERS ==="
  who
}

disk() {
  echo "=== DISK USAGE >70% ==="
  df -h | awk '$5+0 > 70 {print $0}'
}

case "$1" in
  report)
    report | tee -a $LOG 2>> $ERROR_LOG
    ;;
  users)
    users >> $LOG 2>> $ERROR_LOG
    ;;
  disk)
    disk >> $LOG 2>> $ERROR_LOG
    ;;
  *)
    echo "Usage: $0 {report|users|disk}"
    ;;
esac
