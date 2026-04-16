# Stage 1: Build (якщо потрібно було б збирати JS/CSS)
FROM nginx:alpine as builder
# Тут можна додати мініфікацію коду

# Stage 2: Final
FROM nginx:alpine

# 1. Встановлюємо curl для HEALTHCHECK
RUN apk add --no-cache curl

# 2. Налаштовуємо non-root користувача для безпеки
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid /var/cache/nginx /var/log/nginx /etc/nginx/conf.d

# 3. Копіюємо конфіги та HTML
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY html/ /usr/share/nginx/html/

# 4. Перемикаємося на користувача nginx
USER nginx

# 5. HEALTHCHECK
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/ || exit 1

EXPOSE 8080
