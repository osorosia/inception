FROM alpine:3.16

RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client

COPY tools/run.sh /scripts/run.sh
RUN chmod +x /scripts/run.sh
CMD ["/scripts/run.sh"]
