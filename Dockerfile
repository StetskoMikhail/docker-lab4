# Шаг 1: Выбираем базовый образ ОС
# Берем официальный образ Ubuntu 22.04 с Docker Hub
FROM ubuntu:22.04

# Шаг 2: Устанавливаем переменные окружения
# Это нужно чтобы избежать интерактивных запросов во время установки
ENV DEBIAN_FRONTEND=noninteractive

# Шаг 3: Обновляем систему и устанавливаем ПО
# Обновляем список пакетов
RUN apt-get update

# Устанавливаем веб-сервер Nginx
RUN apt-get install -y nginx

# Устанавливаем СУБД MySQL
RUN apt-get install -y mysql-server

# Устанавливаем systemctl для управления службами
RUN apt-get install -y systemctl

# Очищаем кеш apt для уменьшения размера образа
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Шаг 4: Копируем наши конфигурационные файлы
# Копируем конфиг Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Копируем SQL скрипт для инициализации БД
COPY mysql-setup.sql /docker-entrypoint-initdb.d/

# Шаг 5: Открываем порты
# 80 - для веб-сервера Nginx
# 3306 - для MySQL
EXPOSE 80
EXPOSE 3306

# Шаг 6: Копируем и делаем исполняемым скрипт запуска
COPY start-services.sh /start-services.sh
RUN chmod +x /start-services.sh

# Шаг 7: Указываем команду запуска при старте контейнера
CMD ["/start-services.sh"]