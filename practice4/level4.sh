#!/bin/bash

check_user() {
   echo "Current user: $USER"
}

check_user

if [ -z "$1" ]; then
    echo "Помилка: Ви не передали жодного аргументу!"
    exit 1 # Зупиняємо скрипт з помилкою
else
    echo "Ви передали аргумент: $1"
    
    if [[ "$1" =~ ^[0-9]+$ ]] && [ "$1" -gt 10 ]; then
        echo "Супер! Число $1 більше 10."
    fi
fi

ACTION="status"
echo "--- Перевірка case ---"
case $ACTION in
    start) echo "Запускаємо сервіс..." ;;
    stop)  echo "Зупиняємо сервіс..." ;;
    status) echo "Статус: все працює чудово." ;;
esac

echo "--- Рахуємо до 5 ---"
for i in {1..5}; do
    echo "Число: $i"
done

echo "--- Список серверів ---"
SERVERS=("web1" "web2" "db1")
for SERVER in "${SERVERS[@]}"; do
    echo "Перевірка сервера: $SERVER"
done
