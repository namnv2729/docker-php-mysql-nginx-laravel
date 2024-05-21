docker compose build --no-cache && docker compose up --force-recreate -d

# Install web

composer install --no-progress --no-interaction

<!-- php artisan migrate
php artisan optimize -->

php artisan view:cache

# Create laravel caching folders.

RUN mkdir -p /home/web/www/domain.com/storage/framework
RUN mkdir -p /home/web/www/domain.com/storage/framework/cache
RUN mkdir -p /home/web/www/domain.com/storage/framework/testing
RUN mkdir -p /home/web/www/domain.com/storage/framework/sessions
RUN mkdir -p /home/web/www/domain.com/storage/framework/views

# Fix files ownership.

RUN chown -R www-data /home/web/www/domain.com/storage
RUN chown -R www-data /home/web/www/domain.com/storage/framework
RUN chown -R www-data /home/web/www/domain.com/storage/framework/sessions

# Set correct permission.

RUN chmod -R 755 /home/web/www/domain.com/storage
RUN chmod -R 755 /home/web/www/domain.com/storage/logs
RUN chmod -R 755 /home/web/www/domain.com/storage/framework
RUN chmod -R 755 /home/web/www/domain.com/storage/framework/sessions
RUN chmod -R 755 /home/web/www/domain.com/bootstrap
