#! /bin/bash

echo "Restoring database as ordinary user - ignore error when it tries to create extension"
aws s3 cp $BACKUP_FILE - | /usr/bin/time pg_restore --verbose --clean --if-exists \
  --dbname=transit_operations_analytics_data \
  --username=transportation2019 \
  2>&1 | tee restore.log
echo "Tables after restore"
psql --dbname=transit_operations_analytics_data --username=transportation2019 --command='\d+'
psql --dbname=transit_operations_analytics_data --username=transportation2019 --command='SELECT * FROM geometry_columns;'
