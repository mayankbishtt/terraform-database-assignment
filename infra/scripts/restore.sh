#!/bin/bash

set -e

LATEST_BACKUP=$(ls -t backups/*.sql | head -n 1)

echo "Restoring from: $LATEST_BACKUP"

docker exec -i hotel-db psql \
-U postgres \
-d hotel <<EOF

DROP SCHEMA public CASCADE;

CREATE SCHEMA public;

EOF

docker exec -i hotel-db psql \
-U postgres \
-d hotel < "$LATEST_BACKUP"

echo "Restore Completed Successfully"