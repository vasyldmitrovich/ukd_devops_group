#!/bin/bash

# --- 1. ФУНКЦІЇ ---

# Функція для системного звіту (команда: report)
otrymaty_zvit() {
    echo "--- СИСТЕМНИЙ ЗВІТ ---"
    echo "Дата: $(date)"
    echo "Назва хоста (hostname): $(hostname)"
    echo "Час роботи (uptime): $(uptime -p)"
    echo "Використання оперативної пам'яті (RAM):"
    free -h
}

# Функція для перевірки дискового простору (команда: disk)
pereviryty_disk() {
    echo "--- ПЕРЕВІРКА ДИСКОВОГО ПРОСТОРУ (>70%) ---"
    # Читаємо вивід df рядок за рядком, фільтруємо реальні розділи через grep
    df -h | grep '^/dev/' | while read -r ryadok; do
        # Отримуємо відсоток використання (5-й стовпчик) та видаляємо символ %
        vidsotok=$(echo $ryadok | awk '{print $5}' | sed 's/%//')
        # Отримуємо назву розділу (6-й стовпчик)
        rozdil=$(echo $ryadok | awk '{print $6}')
        
        # Перевірка умови: якщо використано більше 70%
        if [ "$vidsotok" -gt 70 ]; then
            echo "УВАГА: Розділ $rozdil заповнений на $vidsotok%!"
        fi
    done
}

# --- 2. ГОЛОВНА ЛОГІКА ТА ЛОГУВАННЯ ---

# Перевіряємо, чи передано аргумент (спецзмінна $# - кількість аргументів)
if [ -z "$1" ]; then
    # Записуємо помилку в errors.log (>>) та виводимо в потік stderr (>&2)
    echo "$(date): Помилка - Аргумент не надано" >> errors.log
    echo "Використання: $0 {report|users|disk}" >&2
    exit 1
fi

case "$1" in
    report)
        # Додаємо звіт у файл script.log і одночасно виводимо на екран
        otrymaty_zvit >> script.log
        otrymaty_zvit 
        ;;
    users)
        echo "Список активних користувачів збережено в лог."
        echo "--- Активні користувачі ($(date)) ---" >> script.log
        who >> script.log
        ;;
    disk)
        # tee -a дозволяє бачити результат в терміналі та дописувати в файл одночасно
        pereviryty_disk | tee -a script.log
        ;;
    *)
        # Якщо введено невідому команду - фіксуємо це в лозі помилок
        echo "$(date): Невідома команда '$1'" >> errors.log
        echo "Невірна опція. Перевірте файл errors.log" >&2
        exit 1
        ;;
esac
