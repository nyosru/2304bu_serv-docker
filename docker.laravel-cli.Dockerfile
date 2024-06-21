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
USER ${PHPUSER}

RUN apt-get update -y && \
    apt-get install -y \
        git \
        libzip-dev \
        docker-ce-cli \
    && docker-php-ext-install pdo_mysql zip && docker-php-ext-enable zip

# Устанавливаем Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Опционально: настройка прав доступа к папкам
# RUN chmod -R 0777 /path/to/your/folder

# Очищаем кеш и временные файлы
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Ваш остальной код Dockerfile продолжает здесь
