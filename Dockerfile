FROM drupal:8-apache

ARG SITE_INSTALL
ARG XDEBUG_INSTALL

RUN apt-get update && apt-get install -y --no-install-recommends \
  ssl-cert \
	curl \
	git \
	mariadb-client \
	vim \
	zip \
	unzip \
	netcat \
	wget

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
  php composer-setup.php && \
  mv composer.phar /usr/local/bin/composer && \
  php -r "unlink('composer-setup.php');"

RUN composer global require drush/drush:10.* && composer global install && ln -s /var/www/.config/composer/vendor/bin/drush /usr/bin/drush

RUN rm -rf /var/www/html/*

COPY apache-drupal.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /var/www/html/web

CMD ["sh", "-c", "/var/www/html/scripts/install.sh && apache2-foreground"]
