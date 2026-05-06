#!/bin/bash
set -e

WP_PATH=/var/www/html

# Wait for MariaDB
echo "Waiting for MariaDB..."
while ! mysqladmin ping -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent 2>/dev/null; do
    sleep 2
done
echo "MariaDB is ready."

cd $WP_PATH

# Download WordPress if not already present
if [ ! -f wp-login.php ]; then
    wp core download --allow-root --locale=en_US
fi

# Create wp-config.php if not already present
if [ ! -f wp-config.php ]; then
    wp config create \
        --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost=mariadb
fi

# Install WordPress if not already installed
if ! wp core is-installed --allow-root 2>/dev/null; then
    wp core install \
        --allow-root \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email

    # Create a regular user
    wp user create \
        --allow-root \
        "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD"
fi

# Run php-fpm in foreground
exec php-fpm7.4 -F
