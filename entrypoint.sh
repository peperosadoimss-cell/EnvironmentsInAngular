#!/bin/sh

# Reemplaza la variable ${API_URL} en la plantilla
envsubst '${API_URL}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec "$@"