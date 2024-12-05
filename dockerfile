FROM php:8.1-fpm-alpine

# Install dependencies and PHP extensions
RUN apk update && apk add --no-cache \
    libzip-dev \
    zip \
    git \
    curl \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-enable pdo_mysql

# Set the working directory
WORKDIR /var/www

# Copy the application files into the container
COPY . .

# Set permissions on Laravel directories
RUN chmod -R 775 storage bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Command to start PHP-FPM
CMD ["php-fpm", "--nodaemonize","--host=0.0.0.0 --port=${PORT}"]
