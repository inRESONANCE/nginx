FROM nginx:1.13.1-perl

RUN mkdir -p /opt/scripts

RUN mkdir /certs

ADD nginx /opt/nginx
COPY nginx.sh /opt/scripts/nginx.sh

COPY nginx/fastcgi_params /etc/nginx/fastcgi_params
COPY nginx/nginx.conf /etc/nginx/nginx.conf

ENV FRAMEWORK=drupal

ENTRYPOINT ["/opt/scripts/nginx.sh"]

CMD ["-g","daemon off;"]
