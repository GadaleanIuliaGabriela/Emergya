#!/bin/bash

composer install

# Waits until mysql container is installed
until nc -z -v -w1 db 3306
do
   sleep 5
done

# Install site optionally
if [[ "${SITE_INSTALL}" == "1" ]]; then
    printf "\n- Installing site -\n\n"
    drush site-install -y test --db-url=mysql://root:drupal@db:3306/drupal --site-name=DrupalProject --account-name=admin --account-pass=admin --account-mail=gadalean.iulia.gabriela@gmail.com
    printf "\n- Site has been successfully installed -\n"
fi

# Install xdebug optionally
if [[ "${XDEBUG_INSTALL}" == "1" ]]; then
    printf "\n- Installing xdebug -\n\n"
    pecl install xdebug
    docker-php-ext-enable xdebug
    cat ../docker/configs/xdebug.ini > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
    printf "\n- Xdebug has been successfully installed -\n"
fi

drush cr
drush -y updb
drush -y cim --partial
drush cr

chown -R www-data:www-data /var/www
