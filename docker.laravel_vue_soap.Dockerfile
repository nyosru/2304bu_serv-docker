FROM node:latest AS node
#FROM php:8.2.0-fpm
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

WORKDIR ${FOLDER}
USER ${PHPUSER}


# Установите необходимые зависимости (в данном случае, расширение SOAP для PHP)
#RUN apt-get update && apt-get install -y \
#    libxml2-dev \
#    && docker-php-ext-install soap
RUN apt-get update -y \
  && apt-get install -y \
     libxml2-dev \
  && apt-get install -y \
     soap \
  && apt-get clean -y \
  && docker-php-ext-install soap \
    && docker-php-ext-install soap \
    && docker-php-ext-enable soap \

RUN apt-get update -y && docker-php-ext-install pdo_mysql \
    && apt-get update && apt-get install -y git \
    &&  apt-get install -y \
    libzip-dev \
    && docker-php-ext-install zip  && docker-php-ext-enable zip


RUN npm install -g npm

# # # Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

#RUN cd /2309livewire && chmod -R 0777 storage
