FROM php:7.1-alpine

MAINTAINER robin@webstronauts.co

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN apk add --update \
		nodejs postgresql-dev && \
	docker-php-ext-install pdo_pgsql

# Install Composer and make it available in the $PATH.
RUN curl -sS https://raw.githubusercontent.com/composer/getcomposer.org/f3333f3bc20ab8334f7f3dada808b8dfbfc46088/web/installer | php -- --quiet --install-dir=/usr/bin/ --filename=composer
