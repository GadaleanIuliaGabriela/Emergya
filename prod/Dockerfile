FROM drupal:8-apache

ARG SITE_INSTALL
ARG CMS_ENVIRONMENT

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

COPY . /opt/drupal

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
  php composer-setup.php && \
  mv composer.phar /usr/local/bin/composer && \
  php -r "unlink('composer-setup.php');"

RUN composer global require drush/drush:10.* && composer global install && ln -s ~/.composer/vendor/bin/drush /usr/bin/drush

RUN composer install --no-interaction

CMD ["sh", "-c", "/opt/drupal/scripts/prod_install.sh && apache2-foreground"]
