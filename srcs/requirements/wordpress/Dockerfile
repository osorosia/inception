FROM alpine:3.16

RUN apk update && apk add --no-cache \
	mariadb-client \
    php8 \
    php8-curl \
    php8-fpm \
    php8-gd \
    php8-json \
    php8-mbstring \
    php8-mysqli \
    php8-opcache \
    php8-phar \
    php8-xml \
    php8-zlib \
    unzip \
    wget \
    ;	

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/bin/wp

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mkdir -p /var/www/html && \
    cp -rf wordpress/* /var/www/html && \
    rm -rf wordpress latest.tar.gz

RUN chmod -R 777 /var/www/html/* && \
	mkdir /restore && \
    cp -rf /var/www/html/* /restore

COPY conf/www.conf /etc/php8/php-fpm.d/www.conf
COPY tools/run.sh /scripts/run.sh 
RUN chmod +x /scripts/*

WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["sh", "/scripts/run.sh"]
