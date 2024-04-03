FROM node:latest AS node

FROM php:8.2-fpm


#FROM php:8.2.0-fpm

RUN apt-get update && apt-get install -y \
		libfreetype-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd

COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

ARG PHPGROUP
ARG PHPUSER
ARG FOLDER

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}
ENV FOLDER=${FOLDER}
 # ENV PHPUSEссылкана

WORKDIR ${FOLDER}
USER ${PHPUSER}

RUN apt-get update -y && docker-php-ext-install pdo_mysql \
    && apt-get update && apt-get install -y git \
    &&  apt-get install -y \
    libzip-dev \
    && docker-php-ext-install zip  && docker-php-ext-enable zip

# # # Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

#RUN chmod -R 0775 storage/
#RUN chown -R www-data:www-data ./


#RUN apt-get update && apt-get install -y \
#		libfreetype-dev \
#		libjpeg62-turbo-dev \
#		libpng-dev \
#	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
#	&& docker-php-ext-install -j$(nproc) gd \

# RUN #apt-get update && apt-get install -y \
#	&& docker-php-ext-install gd


#RUN apt-get update -y \

#    && docker-php-ext-install -j$(nproc) gd \
#    && docker-php-ext-enable gd
## Setup GD extension
#RUN apk add --no-cache \
#      freetype \
#      libjpeg-turbo \
#      libpng \
#      freetype-dev \
#      libjpeg-turbo-dev \
#      libpng-dev \
#    && docker-php-ext-configure gd \
#      --with-freetype=/usr/include/ \
#      # --with-png=/usr/include/ \ # No longer necessary as of 7.4; https://github.com/docker-library/php/pull/910#issuecomment-559383597
#      --with-jpeg=/usr/include/ \
#    && docker-php-ext-install -j$(nproc) gd \
#    && docker-php-ext-enable gd \
#    && apk del --no-cache \
#      freetype-dev \
#      libjpeg-turbo-dev \
#      libpng-dev \
#    && rm -rf /tmp/*


# # update 
# RUN apt-get update 
# RUN  curl -sL https://deb.nodesource.com/setup_18.x | bash 
# RUN apt-get install nodejs 

#RUN cd /home/2308beget && chown -R www-data:www-data storage
#RUN #cd /2309livewire && chmod -R 0777 storage

#RUN #cd /2308beget \
##    chmod -R 0777 storage/


# EXPOSE 9050
# EXPOSE 9000

#USER root
#RUN addgroup -g 1000 app && addgroup www-data app
#RUN adduser -u 1000 -s /bin/sh -D -G app app
#USER www-data

#CMD ["php-fpm"]





# # Arguments defined in docker-compose.yml
# ARG user
# ARG uid

# # Install system dependencies
# RUN apt-get update && apt-get install -y \
#     git \
#     curl \
#     libpng-dev \
#     libonig-dev \
#     libxml2-dev \
#     zip \
#     unzip

# # Clear cache
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# # Install PHP extensions
# RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd
# RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# # Get latest Composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# # Create system user to run Composer and Artisan Commands
# RUN useradd -G www-data,root -u $uid -d /home/$user $user
# RUN mkdir -p /home/$user/.composer && \
#     chown -R $user:$user /home/$user

# # Set working directory
# WORKDIR /var/www

# USER $user





# ENV PHPGROUP=${PHPGROUP}
# ENV PHPUSER=${PHPUSER}
# ENV PHPUSER=phpcat

# RUN mkdir -p /srv/storage && chmod -R 755 /srv/storage

# RUN mkdir -p /srv
# WORKDIR /srv
# WORKDIR /var/www/html/ttt72

# WORKDIR /var/www/html
# RUN mkdir -p /srv/data-www/storage && chmod -R 755 /srv/data-www/storage
# RUN mkdir -p /srv/storage && chmod -R 755 /srv/storages
# RUN chmod -R 755 /srv/data-www/storage
# RUN chmod -R 755 /srv/storage

# RUN chown -R ${PHPUSER}:${PHPGROUP} /srv/storage
# RUN chmod -R 777 /srv/storage

# RUN useradd -G www-data,root -u $uid -d /home/${PHPUSER} ${PHPUSER}

# RUN php composer.phar i \
#     php artisan migrate


# confirm that it was successful 
# RUN node -v
# # npm installs automatically 
# RUN npm -v

# RUN cd /srv \
    # chmod -R 0777 storage/
# RUN chmod -R 0777 storage/
# RUN cd /var/www/html/ttt72 \
#     chmod -R 0777 storage/


#USER ${PHPUSER}
#
# RUN useradd -G www-data,root -u $uid -d /home/${PHPUSER} ${PHPUSER}
