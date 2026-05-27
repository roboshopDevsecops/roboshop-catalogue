#!/usr/bin/env bash
set -e

if [ -f /data/params ]; then
    set -a
    # shellcheck disable=SC1091
    source /data/params
    set +a
fi

MYSQL_HOST="${MYSQL_HOST:-mysql}"
MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-RoboShop@1}"
MYSQL_USER="${MYSQL_USER:-catalogue}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-RoboShop@1}"
MYSQL_DATABASE="${MYSQL_DATABASE:-catalogue}"

echo "Waiting for MySQL at ${MYSQL_HOST}..."
until mysqladmin ping -h "$MYSQL_HOST" -uroot -p"$MYSQL_ROOT_PASSWORD" --silent; do
    sleep 2
done

echo "Running catalogue database setup..."
mysql -h "$MYSQL_HOST" -uroot -p"$MYSQL_ROOT_PASSWORD" < /db/schema.sql
mysql -h "$MYSQL_HOST" -uroot -p"$MYSQL_ROOT_PASSWORD" < /db/app-user.sql
mysql -h "$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /db/master-data.sql
echo "Catalogue database setup complete"
