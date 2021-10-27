# Output to Console /dev/...
FROM alpine

RUN apk update && apk add nginx
RUN adduser -D -g www www

COPY html/ /www
RUN chown -R www:www /var/lib/nginx /www

COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /run/nginx

ENTRYPOINT ["nginx", "-g", "daemon off;"]
