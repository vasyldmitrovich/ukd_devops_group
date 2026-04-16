# Stage 1: Final Image
FROM nginx:alpine

# Копіюємо наші файли в контейнер
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY html/ /usr/share/nginx/html/

# Перевірка здоров'я контейнера (HEALTHCHECK)
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

EXPOSE 80
