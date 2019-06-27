#!/usr/bin/env bash

##############
# migrate.sh #
##############
#
# Description: 
# Updates URL in database so the site can run on other domain
# Replace the constants as you please and run it like this ./migrate.sh
#

export WORDPRESS_FINAL_URL=final_url
export WORDPRESS_TABLE_PREFIX=something_
export WORDPRESS_URL_REPLACE=url_to_replace
export MYSQL_DATABASE=database_name

mysql -uroot -p$MYSQL_ROOT_PASSWORD -D$MYSQL_DATABASE -e "
UPDATE ${WORDPRESS_TABLE_PREFIX}options SET option_value = REPLACE(option_value, '${WORDPRESS_URL_REPLACE}', '${WORDPRESS_FINAL_URL}') WHERE option_name = 'home' OR option_name = 'siteurl'; 
UPDATE ${WORDPRESS_TABLE_PREFIX}posts SET guid = REPLACE(guid, '${WORDPRESS_URL_REPLACE}', '${WORDPRESS_FINAL_URL}'); 
UPDATE ${WORDPRESS_TABLE_PREFIX}posts SET post_content = REPLACE(post_content, '${WORDPRESS_URL_REPLACE}', '${WORDPRESS_FINAL_URL}'); 
UPDATE ${WORDPRESS_TABLE_PREFIX}posts SET post_content = REPLACE(post_content, 'src=\"${WORDPRESS_URL_REPLACE}\"', 'src=\"${WORDPRESS_FINAL_URL}\"'); 
UPDATE ${WORDPRESS_TABLE_PREFIX}posts SET guid = REPLACE(guid, '${WORDPRESS_URL_REPLACE}', '${WORDPRESS_FINAL_URL}') WHERE post_type = 'attachment'; 
UPDATE ${WORDPRESS_TABLE_PREFIX}postmeta SET meta_value = REPLACE(meta_value, '${WORDPRESS_URL_REPLACE}', '${WORDPRESS_FINAL_URL}');"