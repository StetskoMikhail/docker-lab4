FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y nginx

RUN apt-get install -y mysql-server

RUN apt-get install -y systemctl

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf

COPY mysql-setup.sql /docker-entrypoint-initdb.d/

EXPOSE 80
EXPOSE 3306

COPY start-services.sh /start-services.sh
RUN chmod +x /start-services.sh

CMD ["/start-services.sh"]