FROM php:7.2-fpm

MAINTAINER Jesus Dominguez <jdominguez@onestic.com>

RUN mkdir -p /usr/share/man/man1 && mkdir -p /usr/share/man/man7 && \
	apt-get update && apt-get install -qy git curl libmcrypt-dev && \
	yes | pecl install mcrypt-1.0.1 && \
	apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	composer install && \
	ln -f -s .env.pipelines .env && \
	php artisan migrate && \
	./vendor/bin/phpunit -c ./phpunit.xml --testsuite=unit
