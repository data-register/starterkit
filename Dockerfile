FROM php:8.2-apache

# Install required extensions
RUN docker-php-ext-install gd

# Copy kirby project files
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html/site/accounts /var/www/html/site/cache /var/www/html/site/sessions /var/www/html/site/logs /var/www/html/content

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80
