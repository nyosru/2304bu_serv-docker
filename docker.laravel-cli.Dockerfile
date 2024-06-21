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


RUN apt-get update -y && docker-php-ext-install pdo_mysql \
    && apt-get update && apt-get install -y git \
    &&  apt-get install -y \
    libzip-dev \
    && docker-php-ext-install zip  && docker-php-ext-enable zip


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

#RUN chmod 666 /var/run/docker.sock

# Добавление пользователя в группу Docker и предоставление sudo прав
RUN usermod -aG docker ${PHPUSER} \
    && echo "${PHPUSER} ALL=(ALL) NOPASSWD: /usr/bin/docker" > /etc/sudoers.d/docker


# Очищаем кеш и временные файлы
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Ваш остальной код Dockerfile продолжает здесь
