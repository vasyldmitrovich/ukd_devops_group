#!/bin/bash

check_user() {
   echo "--- Перевірка користувача ---"
   echo "Current user: $USER"
}

echo "--- Перевірка аргументу ---"
if [ -z "$1" ]; then
    echo "Помилка: Аргумент не передано!"
else
    # Перевіряємо чи це число і чи воно > 10
    if [[ "$1" =~ ^[0-9]+$ ]] && [ "$1" -gt 10 ]; then
        echo "Так, $1 — це число більше за 10."
    else
        echo "Аргумент $1 — не число або воно не більше 10."
    fi
fi

echo ""
echo "--- Робота з Case ---"
ACTION=$2
case $ACTION in
    start)  echo "Служба запускається..." ;;
    stop)   echo "Служба зупиняється..." ;;
    status) echo "Статус системи: OK" ;;
    *)      echo "Використовуй: start | stop | status як другий аргумент." ;;
esac

echo ""
echo "--- Цикл: Числа від 1 до 5 ---"
for i in {1..5}; do
    echo "Число: $i"
done

echo ""
echo "--- Цикл: Масив серверів ---"
SERVERS=("web1" "web2" "db1")
for server in "${SERVERS[@]}"; do
    echo "Підключення до сервера: $server"
done

# Виклик функції
echo ""
check_user
