#!/bin/bash

# 1. Функція
check_user() {
    echo "Поточний користувач: $USER"
}

# 2. Перевірка аргументів (if)
if [ -z "$1" ]; then
    echo "Помилка: Аргумент не передано!"
else
    # Перевірка чи є аргумент числом та чи > 10
    if [[ "$1" =~ ^[0-9]+$ ]] && [ "$1" -gt 10 ]; then
        echo "Число $1 більше за 10."
    else
        echo "Ви ввели '$1' (не число або <= 10)."
    fi
fi

# 3. Оператор case
ACTION="start" # Можна замінити на $2 для динаміки
case $ACTION in
    start)  echo "Сервіс запускається..." ;;
    stop)   echo "Сервіс зупиняється..." ;;
    status) echo "Статус: OK" ;;
    *)      echo "Невідома команда" ;;
esac

# 4. Цикли та масиви
echo "Лічильник:"
for i in {1..5}; do
    echo "Число: $i"
done

SERVERS=("web1" "web2" "db1")
echo "Список серверів:"
for srv in "${SERVERS[@]}"; do
    echo "Checking server: $srv"
done

check_user



