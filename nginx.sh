#!/bin/bash
set -e

if [ ! -f "/opt/nginx/${FRAMEWORK}.conf" ]; then
  echo "Framework: ${FRAMEWORK} file does not exist"
  exit 1
fi

cp /opt/nginx/${FRAMEWORK}.conf /etc/nginx/conf.d/default.conf

# Set up our certs for the appserver with nginx
#if [ ! -f "/certs/appserver.pem" ]; then
#  openssl genrsa -out /certs/appserver.key 2048 && \
#  openssl req -new -x509 -key /certs/appserver.key -out /certs/appserver.crt -days 365 -subj "/C=US/ST=Massachusetts/L=Northampton/O=inRESONANCE/OU=iR/CN=web" && \
#  cat /certs/appserver.crt /certs/appserver.key > /certs/appserver.pem
#fi

# Run the NGINX
nginx "$@"
