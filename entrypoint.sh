#!/bin/sh

# Reemplaza la variable ${BASE_URL_API} en la plantilla
envsubst '${BASE_URL_API}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec "$@"