FROM php:8.2-fpm

FROM node:latest AS node

#
#FROM php:8.2.0-fpm
#
#ARG PHPGROUP
#ARG PHPUSER
#ARG FOLDER
#
#ENV PHPGROUP=${PHPGROUP}
#ENV PHPUSER=${PHPUSER}
#ENV FOLDER=${FOLDER}
# # ENV PHPUSEссылкана
#
#WORKDIR ${FOLDER}
#USER ${PHPUSER}
#
#
#
#
##RUN apt-get update && apt-get install -y \
##		libfreetype-dev \
##		libjpeg62-turbo-dev \
##		libpng-dev \
##	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
##	&& docker-php-ext-install -j$(nproc) gd
##
##COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
##COPY --from=node /usr/local/bin/node /usr/local/bin/node
##RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
##
##
##RUN apt-get update -y && docker-php-ext-install pdo_mysql \
##    && apt-get update && apt-get install -y git \
##    &&  apt-get install -y \
##    libzip-dev \
##    && docker-php-ext-install zip  && docker-php-ext-enable zip
#
## # # Get latest Composer
#COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
