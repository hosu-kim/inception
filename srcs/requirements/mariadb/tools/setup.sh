#!/bin/bash

# if [ -d ... ]: Check if a specific directory exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
    echo "Database already exists"
else
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mysqld_safe & # Run in the background for a while to run the next commands
    pid="$!" # saves pid

    sleep 5

    # Prints error messages
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    # Cleanup and closure
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
    # Wait until the process is completely finished.
    wait "$pid"
# if: end of if condition on bash
fi

# It completely terminates the setup.sh script,
# and mysqld_safe takes its place.
exec mysqld_safe
