FROM athimel/nginx-php-mongo:latest

ADD src/ /var/www/html/

RUN sed -i "s#daemon off;#daemon on;#g" /etc/nginx/nginx.conf
RUN echo "tail -f /var/log/nginx/*" >> /root/run.sh