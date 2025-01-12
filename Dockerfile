FROM php:8.2-apache

# Install dependencies for GD
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxpm-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Install GD extension
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp \
    --with-xpm

RUN docker-php-ext-install -j$(nproc) gd

# Copy kirby project files
COPY . /var/www/html/

# Create necessary directories AND set permissions
RUN mkdir -p /var/www/html/site/accounts /var/www/html/site/cache /var/www/html/site/sessions /var/www/html/site/logs /var/www/html/content && \
    chown -R www-data:www-data /var/www/html/site/accounts /var/www/html/site/cache /var/www/html/site/sessions /var/www/html/site/logs /var/www/html/content

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80
