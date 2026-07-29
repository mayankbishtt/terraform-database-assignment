#!/bin/bash

set -e

BACKUP_DIR="backups"

mkdir -p $BACKUP_DIR

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

FILE_NAME="$BACKUP_DIR/hotel_backup_$TIMESTAMP.sql"

docker exec hotel-db pg_dump \
-U postgres \
-d hotel > "$FILE_NAME"

echo "Backup Created Successfully"

echo "Location: $FILE_NAME"