#!/bin/bash

echo "=== Запуск служб в Docker контейнере ==="

# Шаг 1: Запускаем MySQL сервер
echo "Запуск MySQL..."
service mysql start

# Ждем немного чтобы MySQL успел запуститься
sleep 3

# Шаг 2: Инициализируем базу данных
echo "Инициализация базы данных..."
if [ -f /docker-entrypoint-initdb.d/mysql-setup.sql ]; then
    mysql < /docker-entrypoint-initdb.d/mysql-setup.sql
    echo "База данных инициализирована"
else
    echo "Файл инициализации БД не найден"
fi

# Шаг 3: Запускаем Nginx
echo "Запуск Nginx..."
nginx

# Шаг 4: Создаем простую HTML страницу для тестирования
mkdir -p /var/www/html
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Лабораторная работа №4</title>
</head>
<body>
    <h1>Добро пожаловать!</h1>
    <p>Веб-сервер Nginx работает успешно!</p>
    <p>Система управления базами данных MySQL также запущена.</p>
    <ul>
        <li>Веб-сервер: Nginx</li>
        <li>СУБД: MySQL</li>
        <li>ОС: Ubuntu 22.04</li>
    </ul>
</body>
</html>
EOF

echo "=== Все службы запущены ==="
echo "Nginx доступен на порту 80"
echo "MySQL доступен на порту 3306"

# Шаг 5: Бесконечный цикл для поддержания работы контейнера
echo "Контейнер запущен и работает..."
while true; do
    sleep 60
done