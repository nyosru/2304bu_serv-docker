FROM php:8.2-fpm

# Определение аргументов и переменных окружения
ARG PHPGROUP=www-data
ARG PHPUSER=www-data
ARG FOLDER=/home/bitrix1
ARG SESSION_PATH=/home/bitrix1/php_session

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}
ENV FOLDER=${FOLDER}
ENV SESSION_PATH=${SESSION_PATH}

# Установка рабочего каталога
WORKDIR ${FOLDER}

# Обновление пакетов и установка необходимых расширений и утилит
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libzip-dev \
    zip \
    unzip \
    curl \
    libicu-dev \
    libonig-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) \
    gd \
    mysqli \
    pdo \
    pdo_mysql \
    zip \
    intl \
    bcmath \
    mbstring \
    opcache \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Настройка прав доступа
RUN chown -R ${PHPUSER}:${PHPGROUP} ${FOLDER}

# Создание пользовательских файлов конфигурации PHP
RUN echo "opcache.revalidate_freq=0" > /usr/local/etc/php/conf.d/opcache-revalidate-freq.ini \
    && echo "display_errors=On" > /usr/local/etc/php/conf.d/display-errors.ini \
    && mkdir -p ${SESSION_PATH} \
    && chown -R www-data:www-data ${SESSION_PATH} \
    && chmod -R 733 ${SESSION_PATH} \
    && echo "session.save_path=${SESSION_PATH}" > /usr/local/etc/php/conf.d/session-save-path.ini

CMD ["php-fpm"]
