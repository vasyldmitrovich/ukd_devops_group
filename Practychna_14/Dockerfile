# Використовуємо легкий образ Alpine
FROM nginx:alpine

# Створюємо користувача для безпеки
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Копіюємо конфіги
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY html /usr/share/nginx/html

# Створюємо пусту сторінку 404
RUN echo "Упс! Сторінку не знайдено." > /usr/share/nginx/html/404.html

# Даємо права нашому користувачу
RUN touch /var/run/nginx.pid && \
    chown -R appuser:appgroup /var/run/nginx.pid /usr/share/nginx/html /var/cache/nginx /var/log/nginx /etc/nginx

USER appuser

HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost/ || exit 1

EXPOSE 80
