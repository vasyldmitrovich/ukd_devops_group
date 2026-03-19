#!/bin/bash

# 1. Функція
check_user() {
   echo "Поточний користувач: $USER"
}

# 2. Перевірка аргумента (if)
if [ -z "$1" ]; then
    echo "Помилка: Аргумент не передано!"
else
    if [ "$1" -gt 10 ] 2>/dev/null; then
        echo "Число $1 більше за 10"
    else
        echo "Це не число або воно <= 10"
    fi
fi

# 3. Використання case
case "$2" in
    start) echo "Запуск сервісу..." ;;
    stop)  echo "Зупинка сервісу..." ;;
    *)     echo "Статус: Очікування (використовуйте start/stop як 2-й аргумент)" ;;
esac

# 4. Цикл та масив
SERVERS=("web1" "web2" "db1")
echo "Список серверів:"
for srv in "${SERVERS[@]}"; do
    echo " - Сервер: $srv"
done

check_user
