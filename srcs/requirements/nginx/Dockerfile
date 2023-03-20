FROM alpine:3.16

RUN apk update && apk add --no-cache \
    nginx \
    openssl

RUN mkdir /etc/nginx/ssl && \
    openssl genrsa -out /etc/nginx/ssl/server.key 2048 && \
    openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt -x509 -days 365 -subj "/C=JP/ST=Tokyo/L=Tokyo/O=42/OU=42tokyo/CN=rnishimo"

COPY conf/default.conf /etc/nginx/http.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
