FROM php:7.4-fpm

ARG PHPGROUP
ARG PHPUSER
ARG FOLDER

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}
ENV FOLDER=${FOLDER}

# Copy composer.lock and composer.json
#COPY ../composer.lock composer.json /var/www/

# Set working directory
WORKDIR ${FOLDER}

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libpq-dev \
    libzip-dev

### Установите необходимые зависимости (в данном случае, расширение SOAP для PHP)
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    && docker-php-ext-install soap \
    && docker-php-ext-enable soap

# Clear cache
#RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_pgsql zip exif pcntl
#RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
#RUN docker-php-ext-install gd

# Install composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
#RUN groupadd -g 1000 www
#RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
#COPY php /var/www

# Copy existing application directory permissions
#COPY --chown=www:www php /var/www

# Change current user to www
#USER www
USER ${PHPUSER}

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]


#FROM node:latest AS node
##FROM php:8.2.0-fpm
#FROM php:7.3-fpm
#
#COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
#COPY --from=node /usr/local/bin/node /usr/local/bin/node
#RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
#
#ARG PHPGROUP
#ARG PHPUSER
#ARG FOLDER
#
#ENV PHPGROUP=${PHPGROUP}
#ENV PHPUSER=${PHPUSER}
#ENV FOLDER=${FOLDER}
#
#WORKDIR ${FOLDER}
#USER ${PHPUSER}
#
#RUN apt-get update -y && docker-php-ext-install pdo_mysql \
#    && apt-get update && apt-get install -y git \
#    &&  apt-get install -y \
#    libzip-dev \
#    && docker-php-ext-install zip  && docker-php-ext-enable zip
#
#RUN npm install -g npm
#
## # # Get latest Composer
#COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
#
##RUN cd /2309livewire && chmod -R 0777 storage
#
#
###FROM node:latest AS node
###FROM php:8.2.0-fpm
##FROM php:7.4-fpm
###FROM php:7.3
##
###COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
###COPY --from=node /usr/local/bin/node /usr/local/bin/node
###RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
##
##ARG PHPGROUP
##ARG PHPUSER
##ARG FOLDER
##
##ENV PHPGROUP=${PHPGROUP}
##ENV PHPUSER=${PHPUSER}
##ENV FOLDER=${FOLDER}
##
##WORKDIR ${FOLDER}
##USER ${PHPUSER}
##
### Установите необходимые зависимости (в данном случае, расширение SOAP для PHP)
##RUN apt-get update && apt-get install -y \
##    libxml2-dev \
##    && docker-php-ext-install soap
##
###RUN apt-get update -y \
###  && apt-get install -y \
###     libxml2-dev \
###  && apt-get install -y \
###     soap \
###  && apt-get clean -y \
###  && docker-php-ext-install soap \
###    && docker-php-ext-install soap \
###    && docker-php-ext-enable soap \
###
##RUN apt-get update -y && docker-php-ext-install pdo_mysql \
##    && apt-get update && apt-get install -y git \
##    &&  apt-get install -y \
##    libzip-dev \
##    && docker-php-ext-install zip  && docker-php-ext-enable zip
###
###RUN npm install -g npm
###
#### # # Get latest Composer
##COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
###RUN cd /2309livewire && chmod -R 0777 storage
##
##
### Expose port 9000 and start php-fpm server
##EXPOSE 9000
##CMD ["php-fpm"]