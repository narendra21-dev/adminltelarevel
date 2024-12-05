# Base image with PHP and required extensions
FROM php:8.1-fpm

# Install system dependencies and Composer
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev zip git curl libxml2-dev unzip \
    libzip-dev libicu-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd intl zip pdo_mysql bcmath


# Set working directoryy
WORKDIR /var/www

# Copy application files
COPY . .



# Expose port 8000
EXPOSE 8000

# Run Laravel application
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]