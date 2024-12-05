# Use an official PHP image with Composer
FROM php:8.2-fpm

# Install necessary extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip git && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install pdo_mysql gd zip bcmath

# Copy application files
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Install Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Run composer install
RUN composer install --no-dev --optimize-autoloader && \
    chmod -R 775 storage bootstrap/cache

# Expose port
EXPOSE 9000

# Start the server
CMD ["php-fpm", "--nodaemonize", "--allow-to-run-as-root","--host=0.0.0.0 --port=${PORT}"]


RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache
