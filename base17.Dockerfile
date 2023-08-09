FROM php:8.2.0-fpm
# FROM php:8.2.0-fpm-alpine
# FROM tangramor/nginx-php8-fpm:php8.2.8_node20.5.0

ARG PHPGROUP
ARG PHPUSER

WORKDIR /srv_base17




# RUN apk update && apk upgrade
# RUN docker-php-ext-install pdo pdo_mysql

RUN apt-get update -y && docker-php-ext-install pdo_mysql
RUN apt-get update && apt-get install -y git
RUN  apt-get install -y \
    libzip-dev \
    npm \
    && docker-php-ext-install zip  && docker-php-ext-enable zip

RUN apt-get update && apt-get install -y git 

# Install NPM
RUN curl https://www.npmjs.com/install.sh | sh

# \
#     && apt-get install -y nodejs
# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


# RUN sudo chown -R ${PHPUSER} /srv_base17/storage

# RUN cd /srv_base17 \
#     chmod -R 0777 storage/
# RUN chown -R ${PHPUSER}:${PHPGROUP} /srv_base17/storage
# RUN chmod -R 777 /srv/storage
# RUN useradd -G ${PHPUSER},root -u $uid -d /home/${PHPUSER} ${PHPUSER}


# # Add user for laravel application
# RUN groupadd -g 1000 www && useradd -u 1000 -ms /bin/bash -g www www
# # Change current user to www
# USER www









# ENV PHPGROUP=${PHPGROUP}
# ENV PHPUSER=${PHPUSER}
# ENV PHPUSER=phpcat


# RUN mkdir -p /srv/storage && chmod -R 755 /srv/storage
# RUN mkdir -p /srv
# WORKDIR /var/www/html
# RUN mkdir -p /srv/data-www/storage && chmod -R 755 /srv/data-www/storage
# RUN mkdir -p /srv/storage && chmod -R 755 /srv/storages
# RUN chmod -R 755 /srv/data-www/storage
# RUN chmod -R 755 /srv/storage

# RUN chown -R ${PHPUSER}:${PHPGROUP} /srv_base17/storage
# RUN chmod -R 777 /srv/storage

# RUN useradd -G www-data,root -u $uid -d /home/${PHPUSER} ${PHPUSER}

# RUN php composer.phar i \
#     php artisan migrate


RUN cd /srv_base17
RUN sudo chown -R ${PHPUSER} /storage
USER ${PHPUSER}

