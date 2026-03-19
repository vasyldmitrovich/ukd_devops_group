#!/bin/bash
check_user() {
   echo "Поточний користувач: $USER"
}

if [ -z "$1" ]; then
    echo "Помилка: не вказано число як аргумент."
elif [ "$1" -gt 10 ]; then
    echo "Число $1 більше за 10."
else
    echo "Число $1 менше або дорівнює 10."
fi

SERVERS=("web1" "web2" "db1")
echo "Список серверів з масиву:"
for srv in "${SERVERS[@]}"; do
    echo "Сервер: $srv"
done

check_user
