#FROM node:latest AS node
FROM php:8.2-fpm

# Копирование Node.js и npm
#COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
#COPY --from=node /usr/local/bin/node /usr/local/bin/node
#RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# Установка аргументов и переменных окружения
ARG PHPGROUP
ARG PHPUSER
ARG FOLDER

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}
ENV FOLDER=${FOLDER}

# Установка рабочей директории
WORKDIR ${FOLDER}

# Переход на пользователя PHPUSER
USER ${PHPUSER}

# Установка необходимых пакетов и расширений PHP
RUN apt-get update -y \
    && apt-get install -y \
       git \
       libzip-dev \
       libxml2-dev \
       libfreetype6-dev \
       libjpeg62-turbo-dev \
       libpng-dev \
       imagemagick \
       libmagickwand-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql zip \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Копирование последней версии Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Настройка прав доступа для хранения
# RUN cd /2309livewire && chmod -R 0777 storage
