FROM alpine:3.17

RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client

COPY tools/run.sh /scripts/run.sh
RUN chmod +x /scripts/run.sh
CMD ["/scripts/run.sh"]
