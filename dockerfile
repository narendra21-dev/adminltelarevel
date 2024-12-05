# Use the official PHP image with required extensions
FROM php:8.1-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev zip git curl libxml2-dev unzip \
    libzip-dev libicu-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd intl zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . .

# Install Composer dependencies
RUN composer install --no-dev --optimize-autoloader --verbose

# Run Laravel commands
RUN php artisan config:cache && php artisan route:cache && php artisan view:cache

# Expose port 8000
EXPOSE 8000

# Run Laravel application
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
