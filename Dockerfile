FROM nginx:alpine

RUN apk add --no-cache ca-certificates apache2-utils

COPY docker-entrypoint.sh /usr/local/bin
COPY nginx.conf /etc/nginx/conf.d/default.conf

ENV PPROF_USER admin
ENV PPROF_PASSWORD admin

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
