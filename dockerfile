FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    php-mbstring \
    php-xml \
    php-curl \
    php-mysql \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www
COPY . .

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer install --no-dev --optimize-autoloader && \
    php artisan config:cache && php artisan route:cache

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=80"]
