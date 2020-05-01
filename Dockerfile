FROM php:7.1-apache

WORKDIR /opt/partkeepr/

ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_DOCUMENT_ROOT /opt/partkeepr/web

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN mv "${PHP_INI_DIR}/php.ini-production" "${PHP_INI_DIR}/php.ini"

# apt all packages
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        pkg-config \
        patch \
        libwebp-dev \
        libxpm-dev \
        libcurl4-openssl-dev \
        libldb-dev \
        libldap2-dev \
        libxml2-dev \
        wget \
        git \
        curl \
        cron \
        --no-install-recommends && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure \
        gd --with-gd --with-webp-dir --with-jpeg-dir \
        --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir \
        --enable-gd-native-ttf && \
        docker-php-ext-install \
        zip \
        ldap \
        bcmath \
        gd \
        intl \
        dom \
        curl \
        pdo_mysql \
        opcache

RUN pecl install apcu_bc-beta \
    && docker-php-ext-enable apcu

COPY docker/php_datetime.ini "${PHP_INI_DIR}/conf.d/"

COPY . ./

RUN mkdir /opt/partkeepr/app/cache

RUN chmod 770 /opt/partkeepr/app \
        && chmod -R 770 /opt/partkeepr/web \
        && chmod -R 770 /opt/partkeepr/web/ \
        && chmod -R 770 /opt/partkeepr/app/cache/ \
        && chmod -R 770 /opt/partkeepr/app/logs \
        && chmod -R 770 /opt/partkeepr/app/logs/ \
        && chmod -R 770 /opt/partkeepr/data/

RUN mv ./app/config/parameters.php.dist ./app/config/parameters.php

RUN composer install

RUN chown -R www-data:www-data /opt/partkeepr && a2enmod rewrite 
