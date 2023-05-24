FROM php:8.2.0-fpm

ARG PHPGROUP
ARG PHPUSER

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}

# RUN mkdir -p /srv
# WORKDIR /srv
# RUN mkdir -p /srv/data-www/storage && chmod -R 755 /srv/data-www/storage

USER ${PHPUSER}

RUN apt-get update -y && docker-php-ext-install pdo_mysql

RUN apt-get update && apt-get install -y git

RUN  apt-get install -y \
    libzip-dev \
    && docker-php-ext-install zip  && docker-php-ext-enable zip

# # Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer