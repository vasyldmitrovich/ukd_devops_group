# Використовуємо офіційний образ Ubuntu
FROM ubuntu:latest

# Оновлюємо список пакетів та встановлюємо потрібні програми
RUN apt-get update && apt-get install -y curl nano

# Вказуємо, що при старті контейнера відкриється термінал
CMD ["/bin/bash"]
