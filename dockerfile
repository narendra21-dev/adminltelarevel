# Use the PHP-FPM base image for compatibility with PHP extensions
FROM php:8.1-fpm-alpine

# Install required system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    php-mbstring \
    php-xml \
    php-curl \
    php-mysql \
    unzip \
    git \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory and copy project files
WORKDIR /var/www
COPY . .

# Set permissions for storage and cache
RUN chmod -R 775 storage bootstrap/cache && chown -R www-data:www-data storage bootstrap/cache

# Expose the necessary port for PHP-FPM
EXPOSE 9000

# Run PHP-FPM as the foreground process
CMD ["php-fpm", "--nodaemonize"]
