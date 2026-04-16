FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY html /usr/share/nginx/html

RUN adduser -D appuser

HEALTHCHECK CMD wget --spider http://localhost || exit 1
