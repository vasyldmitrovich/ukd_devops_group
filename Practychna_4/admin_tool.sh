#!/bin/bash

# 1. Функція звіту
report() {
  echo "--- ЗВІТ ---"
  date
  uptime
}

# 2. Функція перевірки дисків
check_disk() {
  echo "--- ДИСКИ ---"
  df -h
}

# Перевірка параметрів через Case
case "$1" in
  report)
    report >> script.log  # запис результату в лог
    ;;
  disk)
    check_disk 2> errors.log # якщо буде помилка — вона піде в errors.log
    ;;
  *)
    echo "Використовуй: ./admin_tool.sh report або disk"
    ;;
esac
