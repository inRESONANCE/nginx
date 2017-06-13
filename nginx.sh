#!/bin/bash
set -e

if [ ! -f "/opt/nginx/${FRAMEWORK}.conf" ]; then
  echo "Framework: ${FRAMEWORK} file does not exist"
  exit 1
fi

cp /opt/nginx/${FRAMEWORK}.conf /etc/nginx/conf.d/default.conf

# Set up our certs for the server with nginx
if [ ! -f "/certs/server.pem" ]; then
  openssl genrsa -out /certs/server.key 2048 && \
  openssl req -new -x509 -key /certs/server.key -out /certs/server.crt -days 365 -subj "/C=US/ST=Massachusetts/L=Northampton/O=inRESONANCE/OU=iR/CN=web" && \
  cat /certs/server.crt /certs/server.key > /certs/server.pem
fi

# Run the NGINX
nginx "$@"
