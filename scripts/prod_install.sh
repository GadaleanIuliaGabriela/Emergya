#!/bin/bash

# Install site optionally
if [[ "${SITE_INSTALL}" == "1" ]]; then
  printf "\n- Installing site -\n\n"
  drush site-install -y test --db-url=pgsql://yfkjrtmbazvxqo:93c526e7d95308f024ba0969393ab423f25eb5615624b124e8cfcccb969fd2cd@ec2-54-74-77-126.eu-west-1.compute.amazonaws.com:5432/da7ktgieemu0q2 --site-name=DrupalProject --account-name=admin --account-pass=admin --account-mail=gadalean.iulia.gabriela@gmail.com
  drush cset system.site uuid "29ad5c9a-0f76-4799-b8ac-5cd09c743191"
  drush entity:delete shortcut_set
  drush cset language.entity.en uuid "b6f99eeb-3ec8-4f40-a067-91f03e03d42b"
  printf "\n- Site has been successfully installed -\n"
fi

drush cr
drush -y updb
drush -y cim --partial
drush cr

# Generate some content
drush genc 10 --bundles product

chown -R www-data:www-data /var/www
