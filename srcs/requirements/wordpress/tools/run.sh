#!/bin/sh

if [ ! -f wp-config.php ]; then
  cp -rf /restore/* /var/www/html
fi
wp config create \
  --dbhost=$WORDPRESS_DB_HOST \
  --dbname=$WORDPRESS_DB_NAME \
  --dbuser=$WORDPRESS_DB_USER \
  --dbpass=$WORDPRESS_DB_PASSWORD \
  --dbcharset="utf8mb4" \
  --dbcollate="utf8mb4_unicode_ci" \
  --skip-check \
  --force \
  --allow-root

echo "Connecting database..."
while ! echo "show databases;" | mariadb -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME >/dev/null 2>/dev/null; do
  sleep 1
done

cat <<EOF | mariadb -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME | grep wp_users >/dev/null
show tables;
EOF
result=$?

if [ $result -ne 0 ]; then
  echo "Installing Wordpress..."
  wp core install \
    --url=rnishimo.42.fr \
    --title=rnishimo_blog \
    --admin_name=kanrisha \
    --admin_password=a \
    --admin_email=kanrisha@example.com \
    --path=/var/www/html \
    --skip-email \
    --allow-root
  wp user create hutu hutu@example.com \
    --user_pass=a \
    --role=editor \
    --allow-root
fi

echo "Wordpress started!"
exec /usr/sbin/php-fpm8 -F
