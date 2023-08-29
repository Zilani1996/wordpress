FROM php:8.0-fpm-alpine

RUN apk update && apk upgrade
RUN apk add bash
RUN apk add nginx openrc
RUN apk add php8 php8-fpm php8-opcache php8-session php8-json php8-openssl php8-zip  php8-mysqli php8-pdo_mysql php8-pdo_sqlite php8-xml php8-phar php8-intl php8-dom php8-xmlreader php8-ctype php8-iconv php8-simplexml

RUN apk add php8-gd php8-zlib php8-curl

RUN apk add php8 php8-fpm php8-opcache

COPY server/etc/nginx /etc/nginx
COPY server/etc/php /etc/php8
COPY src /usr/share/nginx/html
RUN mkdir /var/run/php
EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

CMD ["/bin/bash", "-c", "php-fpm8 && chmod 777 /var/run/php/php8-fpm.sock && chmod 755 /usr/share/nginx/html/* && nginx -g 'daemon off;'"]
