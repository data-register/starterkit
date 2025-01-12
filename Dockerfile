FROM php:8.2-apache

# Инсталиране на системни зависимости
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install zip

# Активиране на Apache модули
RUN a2enmod rewrite headers

# Задаване на работна директория
WORKDIR /var/www/html

# Копиране на файловете от текущата директория
COPY . .

# Инсталиране на Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Инсталиране на зависимостите
RUN composer install --no-dev

# Настройка на правата
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html
RUN chmod -R 777 content site/accounts

# Конфигуриране на Apache
RUN echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/kirby.conf

RUN a2enconf kirby
