FROM nginx:1.13.1-perl

RUN \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y --force-yes --no-install-recommends install \
    openssl \
    && DEBIAN_FRONTEND=noninteractive apt-get -y clean \
    && DEBIAN_FRONTEND=noninteractive apt-get -y autoclean \
    && DEBIAN_FRONTEND=noninteractive apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*\
    && rm -rf \
    && rm -rf /var/lib/cache/* \
    && rm -rf /var/lib/log/* \
    && rm -rf /tmp/*

RUN mkdir -p /opt/scripts

RUN mkdir /certs

ADD nginx /opt/nginx
COPY nginx.sh /opt/scripts/nginx.sh

COPY nginx/fastcgi_params /etc/nginx/fastcgi_params
COPY nginx/nginx.conf /etc/nginx/nginx.conf

ENV FRAMEWORK=drupal\
    DOCROOT=/var/www/

# Set TERM so text editors/etc. can be used
ENV TERM xterm

EXPOSE 80 443

ENTRYPOINT ["/opt/scripts/nginx.sh"]

CMD ["-g","daemon off;"]
