FROM node:latest AS node
FROM php:8.2.0-fpm


COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

ARG PHPGROUP
ARG PHPUSER

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}
 # ENV PHPUSER=phpcat

WORKDIR /test231012

USER ${PHPUSER}

RUN apt-get update -y && docker-php-ext-install pdo_mysql \
    && apt-get update && apt-get install -y git \
    &&  apt-get install -y \
    libzip-dev \
    && docker-php-ext-install zip  && docker-php-ext-enable zip

#    # Install Memcached for php 7
#RUN apt-get update -y && docker-php-ext-install memcached \
#    && docker-php-ext-enable memcached && apt-get update
##RUN set -eux \
##    && pecl install memcached \
##    && docker-php-ext-enable memcached \
##    && true

# # # Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

#RUN cd /2309livewire && chmod -R 0777 storage


