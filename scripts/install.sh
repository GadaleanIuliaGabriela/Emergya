#!/bin/bash

composer install --no-interaction

# Waits until mysql container is installed
until nc -z -v -w1 db 3306
do
   sleep 5
done

# Install site optionally
if [[ "${SITE_INSTALL}" == "1" ]]; then
    printf "\n- Installing site -\n\n"
    drush site-install -y test --db-url=mysql://root:drupal@db:3306/drupal --site-name=DrupalProject --account-name=admin --account-pass=admin --account-mail=gadalean.iulia.gabriela@gmail.com
    drush cset system.site uuid "29ad5c9a-0f76-4799-b8ac-5cd09c743191"
    drush entity:delete shortcut_set
    drush cset language.entity.en uuid "b6f99eeb-3ec8-4f40-a067-91f03e03d42b"
    printf "\n- Site has been successfully installed -\n"
fi

# Install xdebug optionally
if [[ "${XDEBUG_INSTALL}" == "1" ]]; then
    printf "\n- Installing xdebug -\n\n"
    docker-php-ext-enable xdebug
    cat ./docker/configs/xdebug.ini > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
    printf "\n- Xdebug has been successfully installed -\n"
fi

drush cr
drush -y updb
drush -y cim --partial
drush cr

# Generate some content
drush genc 10 --bundles product

chown -R www-data:www-data /var/www
