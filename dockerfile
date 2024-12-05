FROM php:8.1-fpm

# Update and install required packages
RUN apt-get update && apt-get install -y \
    php-mbstring \
    php-xml \
    php-curl \
    php-mysql \
    unzip \
    git \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . .

# Set permissions for Laravel directories
RUN chmod -R 775 storage bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
