FROM nginx:alpine
RUN touch /var/run/nginx.pid &&     chown -R nginx:nginx /var/run/nginx.pid /var/cache/nginx /var/log/nginx /etc/nginx
USER nginx
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY html/ /usr/share/nginx/html/
HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://localhost:8080/ || exit 1
EXPOSE 8080
