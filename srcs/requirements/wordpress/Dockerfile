FROM alpine:3.13

RUN apk update && apk add --no-cache \
	mariadb-client \
	php7-json \
	php7-phar \
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

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/bin/wp

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mkdir -p /var/www/html && \
    cp -rf wordpress/* /var/www/html && \
    rm -rf wordpress latest.tar.gz

COPY conf/wp-config.php /var/www/html 
RUN chmod -R 777 /var/www/html/* && \
	mkdir /restore && \
    cp -rf /var/www/html/* /restore

COPY conf/www.conf /etc/php7/php-fpm.d/www.conf
COPY tools/run.sh /scripts/run.sh 
RUN chmod +x /scripts/*

WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["sh", "/scripts/run.sh"]
