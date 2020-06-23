FROM php:7.2-fpm-alpine3.7

ENV COMPOSER_NO_INTERACTION=1

RUN set -ex \
        && apk add --update --no-cache \
        freetype \
        libpng \
        libjpeg-turbo \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        libxml2-dev \
        autoconf \
        g++ \
        imagemagick \
        imagemagick-dev \
        libtool \
        make \
        pcre-dev \
        postgresql-dev \
        postgresql \
        libintl \
        icu \
        icu-dev \
        bash \
        jq \
        git \
        findutils \
        gzip \
        && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install bcmath mbstring iconv gd soap zip intl mysqli pdo pdo_mysql \
        && pecl install imagick redis \
        && docker-php-ext-enable imagick redis \
        && rm -rf /tmp/pear \
        && apk del freetype-dev libpng-dev libjpeg-turbo-dev autoconf g++ libtool make pcre-dev

RUN apk add gnu-libiconv --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY ./.docker-config/php/php.ini /usr/local/etc/php/

RUN mkdir -p /var/www/html/storage/rebrand && \
        mkdir -p /var/www/html/storage/runtime/mutex && \
        mkdir -p /var/www/html/storage/logs && \
        mkdir -p /var/www/html/config && \
        mkdir -p /var/www/html/modules && \
        mkdir -p /var/www/html/templates && \
        mkdir -p /var/www/html/web && \
        mkdir -p /var/www/html/vendor && \
        touch /var/www/html/craft && \
        touch /var/www/html/composer.json && \
        chown -R www-data:www-data /var/www/html

COPY --chown=www-data:www-data ./craftcms/composer.json /var/www/html/composer.json
RUN composer install -d /var/www/html/ && \
        chown -R www-data:www-data /var/www/html/vendor && \
        chown -R www-data:www-data /var/www/html/composer.lock

COPY --chown=www-data:www-data ./craftcms/config /var/www/html/config
COPY --chown=www-data:www-data ./craftcms/modules /var/www/html/modules
COPY --chown=www-data:www-data ./craftcms/templates /var/www/html/templates
COPY --chown=www-data:www-data ./craftcms/web /var/www/html/web
COPY --chown=www-data:www-data ./craftcms/craft /var/www/html/craft

COPY ./.docker-config/craft/scripts /scripts
RUN chown -R www-data:www-data /scripts \
        && chmod -R +x /scripts

WORKDIR /var/www/html
RUN chown -R www-data:www-data .

ENTRYPOINT [ "/scripts/run.sh" ]
CMD [ "docker-php-entrypoint", "php-fpm"]
VOLUME [ "/var/www/html" ]


