FROM alpine:3.16

RUN apk update && apk add --no-cache \
    nginx
COPY conf/default.conf /etc/nginx/http.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
