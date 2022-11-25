FROM alpine:3.16
RUN apk add --no-cache nginx zola \
 && mkdir -p /tmp/website /var/www
COPY . /tmp/website
RUN mv /tmp/website/default.conf /etc/nginx/http.d \
 && cd /tmp/website \
 && zola build \
 && mv public /var/www \
 && cd ~ \
 && rm -rv /tmp/website \
 && apk del zola

EXPOSE 80
STOPSIGNAL SIGQUIT
ENTRYPOINT ["nginx", "-g", "daemon off;"]
