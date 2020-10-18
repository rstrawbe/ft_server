FROM debian:buster

RUN apt-get update && apt-get dist-upgrade
RUN apt-get -y install nginx
RUN apt-get -y install default-mysql-server

COPY ./srcs/ngnx.conf /etc/nginx/sites-available/localhost
COPY ./srcs/init.sh /

CMD bash /init.sh
