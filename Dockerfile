FROM teran/php5-fpm:latest

MAINTAINER Igor Shishkin <me@teran.ru>
LABEL application=wordpress
LABEL version=4.8.2
LABEL description="Wordpress==4.8.2 running on php5-fpm"

RUN wget -O /tmp/wordpress.tgz https://wordpress.org/wordpress-4.8.2.tar.gz && \
    sha=$(wget -O- https://wordpress.org/wordpress-4.8.2.tar.gz.sha1) && \
    md5=$(wget -O- https://wordpress.org/wordpress-4.8.2.tar.gz.md5) && \
    echo "${sha}  /tmp/wordpress.tgz" | shasum -c && \
    echo "${md5}  /tmp/wordpress.tgz" | md5sum -c && \
    mkdir -p /var/www /tmp/wordpress && \
    tar xvfz /tmp/wordpress.tgz -C /tmp/wordpress && \
    mv /tmp/wordpress/wordpress/* /var/www/ && \
    rm -rf /tmp/wordpress.tgz /tmp/wordpress /var/www/html && \
    chown -R www-data:www-data /var/www/*
ADD nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
