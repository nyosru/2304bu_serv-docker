FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    unzip git sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite

# устанавливаем зависимости для pdo_mysql
RUN apt-get update && apt-get install -y libonig-dev libzip-dev unzip libpq-dev default-mysql-client \
    && docker-php-ext-install pdo pdo_mysql mysqli

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
