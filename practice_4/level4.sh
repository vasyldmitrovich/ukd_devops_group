#!/bin/bash

check_user() {
    echo "Поточний користувач: $USER"
}

if [ -z "$1" ]; then
    echo "Помилка: Аргумент не передано! (Введіть число після назви скрипта)"
else
    # Перевірка, чи є аргумент числом і чи воно > 10
    if [ "$1" -gt 10 ] 2>/dev/null; then
        echo "Результат: Число $1 більше за 10."
    else
        echo "Результат: Аргумент $1 не є числом більше 10."
    fi
fi

echo "--------------------------"

ACTION=$2
case "$ACTION" in
    start)
        echo "Дія: Запуск сервісу..."
        ;;
    stop)
        echo "Дія: Зупинка сервісу..."
        ;;
    status)
        echo "Дія: Перевірка статусу..."
        ;;
    *)
        echo "Дія: Невідома операція (спробуйте start, stop або status)"
        ;;
esac

echo "--------------------------"

echo "Цикл від 1 до 5:"
for i in {1..5}; do
    echo "Число: $i"
done

SERVERS=("web1" "web2" "db1")
echo "Обхід масиву серверів:"
for SERVER in "${SERVERS[@]}"; do
    echo "Підключення до: $SERVER..."
done

echo "--------------------------"

check_user
