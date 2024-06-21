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
        software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update && apt-get install -y docker-ce-cli \
    && docker-php-ext-install pdo_mysql zip && docker-php-ext-enable zip \
    && usermod -aG docker ${PHPUSER} \
    && echo "${PHPUSER} ALL=(ALL) NOPASSWD: /usr/bin/docker" > /etc/sudoers.d/docker

USER ${PHPUSER}

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Опционально: настройка прав доступа к папкам
# RUN chmod -R 0777 /path/to/your/folder

# Очищаем кеш и временные файлы
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Ваш остальной код Dockerfile продолжает здесь
