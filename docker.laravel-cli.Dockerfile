# Используем два базовых образа: Node.js и PHP
FROM node:latest AS node
FROM php:8.2-fpm

# Копируем Node.js и npm из образа node
COPY --from=node /usr/local /usr/local

# Устанавливаем зависимости PHP и инструменты
ARG PHPGROUP
ARG PHPUSER
ARG FOLDER

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}
ENV FOLDER=${FOLDER}

WORKDIR ${FOLDER}

# Установка зависимостей и добавление пользователя в группу Docker
RUN apt-get update -y && \
    apt-get install -y \
        git \
        libzip-dev \
        curl \
        gnupg \
        sudo \
        apt-transport-https \
        ca-certificates \
        software-properties-common

# Установка Docker CLI
RUN curl -fsSL https://get.docker.com | sh

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Опционально: настройка прав доступа к папкам
# RUN chmod -R 0777 /path/to/your/folder

# Очищаем кеш и временные файлы
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Ваш остальной код Dockerfile продолжает здесь
