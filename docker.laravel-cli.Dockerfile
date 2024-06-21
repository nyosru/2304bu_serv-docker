FROM node:latest AS node
FROM php:8.2-fpm

# Копирование Node.js и npm из образа node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# Установка зависимостей PHP и инструментов
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
    && docker-php-ext-install pdo_mysql zip && docker-php-ext-enable zip

# Установка Docker CLI
RUN apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update && apt-get install -y docker-ce-cli

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Опционально: настройка прав доступа к папкам (расскомментируйте и измените по необходимости)
# RUN chmod -R 0777 /path/to/your/folder

# Очистка кеша и временных файлов
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Ваш остальной код Dockerfile продолжает здесь
