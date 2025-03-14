# Используем официальный PHP образ с поддержкой FPM
FROM php:8.2-fpm

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /var/www

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    npm \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl \
    && docker-php-ext-enable opcache

# Устанавливаем Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Устанавливаем Node.js (версия 18) и npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && npm install -g npm@latest

# Копируем файлы из локального окружения в контейнер
COPY . /var/www

# Устанавливаем владельца файлов и задаем права доступа
RUN chown -R www-data:www-data /var/www && \
    chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Устанавливаем зависимости Laravel
RUN composer install --no-dev --optimize-autoloader && \
    npm install && \
    npm run build

# Указываем, какой порт будет прослушивать PHP-FPM
EXPOSE 9000

# Запускаем PHP-FPM в качестве процесса по умолчанию
CMD ["php-fpm"]
