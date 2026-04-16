FROM alpine:latest as builder
RUN echo "Building process..."

FROM nginx:alpine

RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid /var/cache/nginx /var/log/nginx /etc/nginx/conf.d

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY html/ /usr/share/nginx/html/

USER nginx

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/ || exit 1

EXPOSE 8080
