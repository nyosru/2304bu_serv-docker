FROM php:8.2.0-fpm


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

# # Get latest Composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# # Create system user to run Composer and Artisan Commands
# RUN useradd -G www-data,root -u $uid -d /home/$user $user
# RUN mkdir -p /home/$user/.composer && \
#     chown -R $user:$user /home/$user

# # Set working directory
# WORKDIR /var/www

# USER $user








ARG PHPGROUP
ARG PHPUSER

# ENV PHPGROUP=${PHPGROUP}
# ENV PHPUSER=${PHPUSER}
# ENV PHPUSER=phpcat

# RUN mkdir -p /srv/storage && chmod -R 755 /srv/storage

# RUN mkdir -p /srv
# WORKDIR /srv
# WORKDIR /var/www/html/ttt72
WORKDIR /srv
# WORKDIR /var/www/html
# RUN mkdir -p /srv/data-www/storage && chmod -R 755 /srv/data-www/storage
# RUN mkdir -p /srv/storage && chmod -R 755 /srv/storages
# RUN chmod -R 755 /srv/data-www/storage
# RUN chmod -R 755 /srv/storage

# RUN chown -R ${PHPUSER}:${PHPGROUP} /srv/storage
# RUN chmod -R 777 /srv/storage

# RUN useradd -G www-data,root -u $uid -d /home/${PHPUSER} ${PHPUSER}
USER ${PHPUSER}

RUN apt-get update -y && docker-php-ext-install pdo_mysql
RUN apt-get update && apt-get install -y git
RUN  apt-get install -y \
    libzip-dev \
    && docker-php-ext-install zip  && docker-php-ext-enable zip

# # Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# RUN php composer.phar i \
#     php artisan migrate


# update 
RUN apt-get update 
# install curl 
# RUN apt-get install curl 
# get install script and pass it to execute: 
RUN  curl -sL https://deb.nodesource.com/setup_18.x | bash 
# and install node 
RUN apt-get install nodejs 
# confirm that it was successful 
RUN node -v
# npm installs automatically 
RUN npm -v

# RUN cd /srv \
    # chmod -R 0777 storage/
# RUN cd /var/www/html/ttt72 \
#     chmod -R 0777 storage/
RUN cd /srv \
    chmod -R 0777 storage/

EXPOSE 9000

CMD ["php-fpm"]