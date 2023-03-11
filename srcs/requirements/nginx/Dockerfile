FROM alpine:3.17

RUN apk update && apk add --no-cache nginx
# COPY conf/default.conf /etc/nginx/http.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
