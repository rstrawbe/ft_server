FROM debian:buster
RUN apt-get update && apt-get install -y \
    curl \
    default-mysql-server \
    nginx \
    php-common \
    php7.3 \
    php7.3-fpm \
    php7.3-mysql \
    php7.3-cli \
    php7.3-common \
    php7.3-json \
    php7.3-opcache \
    php7.3-readline \
    php7.3-mbstring \
    php7.3-xml \
    php7.3-gd \
    php7.3-curl \
    && mkdir /var/www/localhost \
    && mkdir /var/www/localhost/pma \
    && mkdir /usr/share/phpmyadmin \
    && curl -o pma.tar.gz "https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz" \
    && tar -xzf pma.tar.gz -C /usr/share/phpmyadmin --strip-components 1 \
    && rm pma.tar.gz && rm -rf /var/lib/apt/lists/*

RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 3650 -nodes \
    -out localhost.crt -keyout localhost.key \
    -subj "/C=RU/ST=MSK/L=MSK/O=PRIVATE/OU=PRIVATT/CN=localhost" \
    && mv localhost.crt /etc/ssl/certs/ \
    && mv localhost.key /etc/ssl/private/

COPY ./srcs/wordpress_v5.tar.gz /var/www/
COPY ./srcs/ngnx.conf /var/www/
COPY ./srcs/init.sh /

#EXPOSE 80 443
CMD bash /init.sh