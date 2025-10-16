-- Инициализация базы данных

-- Создаем базу данных для нашего проекта
CREATE DATABASE IF NOT EXISTS lab4_db;

-- Создаем пользователя для работы с базой данных
CREATE USER IF NOT EXISTS 'lab4_user'@'%' IDENTIFIED BY 'lab4_password';

-- Даем пользователю все права на созданную базу
GRANT ALL PRIVILEGES ON lab4_db.* TO 'lab4_user'@'%';

-- Применяем изменения прав
FLUSH PRIVILEGES;

-- Создаем тестовую таблицу для проверки
USE lab4_db;

CREATE TABLE IF NOT EXISTS test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Вставляем тестовые данные
INSERT INTO test_table (name) VALUES ('Test User 1');
INSERT INTO test_table (name) VALUES ('Test User 2');