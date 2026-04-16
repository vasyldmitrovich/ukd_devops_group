# --- STAGE 1: Builder (Мультистейдж для виконання вимоги) ---
FROM alpine:latest AS builder
# Просто створюємо файл-маркер, щоб показати роботу multi-stage
RUN echo "Built by DevOps Student" > /build_info.txt

# --- STAGE 2: Production Image ---
FROM nginx:alpine

# Встановлюємо curl для Healthcheck
RUN apk add --no-cache curl

# Видаляємо дефолтні конфіги
RUN rm /etc/nginx/conf.d/default.conf /etc/nginx/nginx.conf

# Копіюємо наш кастомний конфіг
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Налаштування безпеки: створюємо необхідні папки і даємо права користувачу nginx
RUN mkdir -p /var/cache/nginx && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx && \
    touch /tmp/nginx.pid && \
    chown -R nginx:nginx /tmp/nginx.pid && \
    chown -R nginx:nginx /usr/share/nginx/html

# Копіюємо файл з першого стейджу (демонстрація multi-stage)
COPY --from=builder /build_info.txt /usr/share/nginx/html/build_info.txt

# Змінюємо користувача на non-root
USER nginx

# Додаємо HEALTHCHECK (перевіряємо порт 8080)
HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://localhost:8080/ || exit 1

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
