#!/bin/bash

chown www-data:www-data -R /var/www/html

set -e

source /scripts/helpers.sh
source /scripts/database.sh

setup_database &
SETUP_PID=$!

wait $SETUP_PID

exec "$@"