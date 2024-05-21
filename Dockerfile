# Used for prod build.
FROM php:8.2-fpm

# Adjust user permission & group
RUN usermod --uid 1000 www-data
RUN groupmod --gid 1001 www-data

# Install dependencies.
RUN apt-get update && apt-get install -y unzip libpq-dev libcurl4-gnutls-dev nginx libonig-dev

# Install PHP extensions.
RUN docker-php-ext-install mysqli pdo pdo_mysql bcmath curl opcache mbstring

# Copy composer executable.
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy existing application directory contents
COPY ./www /var/www/html

# Copy files from current folder to container current folder (set in workdir).
COPY --chown=www-data:www-data ./www /var/www/html

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]

# Run the entrypoint file.
# ENTRYPOINT [ "entrypoint.sh" ]