#FROM node:latest AS node
#FROM php:8.2.0-fpm
#FROM php:8.2-fpm
FROM php:7.3


#COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
#COPY --from=node /usr/local/bin/node /usr/local/bin/node
#RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

ARG PHPGROUP
ARG PHPUSER
ARG FOLDER

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}
ENV FOLDER=${FOLDER}
 # ENV PHPUSER=phpcat

WORKDIR ${FOLDER}

USER ${PHPUSER}


RUN apt-get update -y && docker-php-ext-install pdo_mysql \
    && apt-get update && apt-get install -y git \
    &&  apt-get install -y \
    libzip-dev \
    && docker-php-ext-install zip  && docker-php-ext-enable zip


#RUN apt-get update && apt-get install -y libpng-dev  &&  docker-php-ext-install gd

RUN apt-get update && apt-get install -y libmcrypt-dev mysql-client php-soap libxml2-dev libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libgd-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install mcrypt pdo_mysql soap gd exif


RUN apt-get install -y \
    libbz2-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libxpm-dev \
    libvpx-dev \
    libmcrypt-dev \
    libmemcached-dev \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure gd \
        --with-freetype-dir=/usr/lib/x86_64-linux-gnu/ \
        --with-jpeg-dir=/usr/lib/x86_64-linux-gnu/ \
        --with-xpm-dir=/usr/lib/x86_64-linux-gnu/ \
        --with-vpx-dir=/usr/lib/x86_64-linux-gnu/ \
    && \
      docker-php-ext-install \
        bcmath \
        bz2 \
        exif \
        ftp \
        gd \
        gettext \

RUN yum install gcc php-devel php-pear
RUN yum install ImageMagick ImageMagick-devel
RUN pecl install imagick
RUN echo "extension=imagick.so" > /etc/php.d/imagick.ini

# # # Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

#RUN cd /2309livewire && chmod -R 0777 storage
