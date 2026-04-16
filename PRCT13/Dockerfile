# Stage 1: Build (якщо потрібно було б компілювати JS/CSS)
FROM alpine:latest as builder
RUN echo "Building process..."

# Stage 2: Production
FROM nginx:alpine

# Налаштування безпеки: створення non-root користувача
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid /var/cache/nginx /var/log/nginx /etc/nginx/conf.d

# Копіюємо конфіги та контент
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY html/ /usr/share/nginx/html/

# Налаштування прав для користувача nginx
USER nginx

# Перевірка здоров'я
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/ || exit 1

EXPOSE 8080
