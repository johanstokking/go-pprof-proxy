#!/bin/sh
set -e

htpasswd -bc /etc/nginx/.htpasswd $PPROF_USER $PPROF_PASSWORD

exec "$@"
