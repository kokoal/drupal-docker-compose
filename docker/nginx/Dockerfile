ARG nginx_version

FROM nginx:$nginx_version

COPY site.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/html