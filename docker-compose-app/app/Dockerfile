FROM python:3.9-slim

# Встановлюємо необхідні бібліотеки для роботи Python з Flask та MySQL
RUN pip install flask mysql-connector-python

# Копіюємо наш код у папку /app всередині контейнера
COPY app.py /app/app.py

# Встановлюємо робочу директорію
WORKDIR /app

# Команда, яка запустить додаток при старті контейнера
CMD ["python", "app.py"]
