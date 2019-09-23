ARG NGINX_VERSION

FROM nginx:${NGINX_VERSION}

COPY site.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/html