# FROM wordpress:php7.4-fpm
# TODO: build from the pnultimate stable version
FROM alpine:3.13

RUN apk update && apk add --no-cache \
    php7 \
    php7-curl \
    php7-fpm \
    php7-gd \
    php7-mbstring \
    php7-mysqli \
    php7-opcache \
    php7-xml \
    php7-zlib \
    unzip \
    wget \
    ;

RUN wget https://wordpress.org/latest.tar.gz

RUN tar -xzvf latest.tar.gz && \
    mkdir -p /var/www/html && \
    cp -rf wordpress/* /var/www/html && \
    rm -rf wordpress latest.tar.gz

