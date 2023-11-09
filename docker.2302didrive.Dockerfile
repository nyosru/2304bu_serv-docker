FROM node:latest AS node
#FROM php:8.2.0
FROM php:8.2-fpm

COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

ARG PHPGROUP
ARG PHPUSER
ARG FOLDER

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}
ENV FOLDER=${FOLDER}

#WORKDIR ${FOLDER}
WORKDIR /2302didrive

USER ${PHPUSER}

RUN apt-get update -y && docker-php-ext-install pdo_mysql
#RUN apt-get update -y && docker-php-ext-install pdo_mysql \
RUN apt-get update && apt-get install -y git
#    && apt-get update && apt-get install -y git \
RUN apt-get install -y libzip-dev
#    && apt-get install -y libzip-dev \
RUN apt-get update -y \
    && docker-php-ext-install zip  && docker-php-ext-enable zip

# # # Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

#RUN cd /2309livewire && chmod -R 0777 storage
