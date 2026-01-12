# Стадия 1: Node для npm
FROM node:latest AS node
#FROM node:20 AS node

FROM php:8.2-fpm

# Стадия 2: Основной образ PHP
FROM php:8.2-fpm

# Копируем node и npm из стадии node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && npm install -g npm@latest

# Аргументы для пользователя и папки
ARG PHPGROUP=www-data
ARG PHPUSER=www-data
ARG FOLDER=/var/www/html

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}
ENV FOLDER=${FOLDER}

# Создаём пользователя, если его нет
RUN if ! id -u ${PHPUSER} >/dev/null 2>&1; then \
        useradd -m -u 1000 -g ${PHPGROUP} -s /bin/bash ${PHPUSER}; \
    fi

# Установка зависимостей и расширений в одном RUN (лучше для кэша)
RUN apt-get update && apt-get install -y \
        git \
        libzip-dev \
        libxml2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        zip \
        soap \
        gd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Composer из официального образа
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Устанавливаем рабочую директорию
WORKDIR ${FOLDER}

# Копируем проект (лучше делать это после установки зависимостей)
COPY --chown=${PHPUSER}:${PHPGROUP} . ${FOLDER}

# Права на storage и bootstrap/cache (очень важно для Laravel)
RUN chmod -R 775 storage bootstrap/cache \
    && chown -R ${PHPUSER}:${PHPGROUP} storage bootstrap/cache

# Отключаем опасные функции PHP (защита от webshell)
RUN echo "disable_functions = phpinfo,eval,shell_exec,system,passthru,exec,proc_open,popen,gzinflate,str_rot13,gzuncompress,gzdecode" > /usr/local/etc/php/conf.d/security.ini \
    && echo "allow_url_fopen = Off" >> /usr/local/etc/php/conf.d/security.ini \
    && echo "allow_url_include = Off" >> /usr/local/etc/php/conf.d/security.ini

# Переключаемся на пользователя
USER ${PHPUSER}

# Установка зависимостей Composer и npm (если нужно)
RUN composer install --optimize-autoloader --no-dev \
    && npm install && npm run build   # если у тебя Vite или Mix

# Оптимизация Laravel
RUN php artisan optimize:clear \
    && php artisan config:cache \
    && php artisan route:cache \
    && php artisan view:cache