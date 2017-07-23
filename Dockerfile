FROM php:7.1

MAINTAINER robin@webstronauts.co

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install https transport (required for yarn)		
RUN apt-get update && apt-get install -y \		
	apt-transport-https ca-certificates

# Add nodesource repo to have newer Node.js version installed
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

# Add official Yarn package repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y \
        automake git libpng-dev libpq-dev libtool nodejs unzip yarn && \
    docker-php-ext-install pdo_mysql pdo_pgsql

# Copy ini file with CircleCI specific PHP configuration.
COPY php.ini /usr/local/etc/php/conf.d/circleci.ini

# Install Composer and make it available in the $PATH.
RUN curl -sS https://raw.githubusercontent.com/composer/getcomposer.org/f3333f3bc20ab8334f7f3dada808b8dfbfc46088/web/installer | php -- --quiet --install-dir=/usr/bin/ --filename=composer
