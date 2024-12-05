FROM php:8.1-fpm

# Install necessary extensions and tools
RUN apt-get update && apt-get install -y \
    php-mbstring \
    php-xml \
    php-curl \
    php-mysql \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_mysql

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . .

# Set permissions
RUN chmod -R 775 storage bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM as root
CMD ["php-fpm", "--nodaemonize", "--allow-to-run-as-root","--host=0.0.0.0", "--port=80"]
