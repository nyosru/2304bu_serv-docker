#FROM php:7.4-fpm
FROM php:8.2-fpm

# Установите необходимые PHP расширения
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli pdo pdo_mysql zip

# Установите Composer
#COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


# Настройка прав доступа
#RUN chown -R ${PHPUSER}:${PHPGROUP} ${FOLDER}


#WORKDIR /var/www/html
