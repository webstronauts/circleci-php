FROM php:7.1

MAINTAINER robin@webstronauts.co

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Add nodesource repo to have newer node.js version installed
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN apt-get update && apt-get install -y \
        automake git libpng-dev libpq-dev libtool nodejs unzip && \
    docker-php-ext-install pdo_pgsql

# Install Composer and make it available in the $PATH.
RUN curl -sS https://raw.githubusercontent.com/composer/getcomposer.org/f3333f3bc20ab8334f7f3dada808b8dfbfc46088/web/installer | php -- --quiet --install-dir=/usr/bin/ --filename=composer
