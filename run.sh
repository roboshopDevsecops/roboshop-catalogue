#!/usr/bin/env bash
set -e

if [ -f /data/params ]; then
    set -a
    # shellcheck disable=SC1091
    source /data/params
    set +a
fi

export MYSQL_HOST="${MYSQL_HOST:-mysql}"
export MYSQL_USER="${MYSQL_USER:-catalogue}"
export MYSQL_PASSWORD="${MYSQL_PASSWORD:-RoboShop@1}"
export MYSQL_DATABASE="${MYSQL_DATABASE:-catalogue}"
export PORT="${CATALOGUE_SERVER_PORT:-8080}"

exec ./catalogue
