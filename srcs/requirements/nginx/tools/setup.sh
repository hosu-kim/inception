#!/bin/bash

if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Cadet/CN=\$DOMAIN_NAME"
fi

exec nginx -g "daemon off;"
