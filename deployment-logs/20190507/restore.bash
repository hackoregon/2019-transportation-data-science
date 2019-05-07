#! /bin/bash

echo "Checksumming backup file"
sha512sum -c transit_operations_analytics_data.backup.sha512sum
echo "Tables before restore"
psql --dbname=transit_operations_analytics_data --username=transportation2019 -c '\d+'
echo "Restoring database as ordinary user - ignore error when it tries to create extension"
/usr/bin/time pg_restore --verbose \
  --dbname=transit_operations_analytics_data \
  --username=transportation2019 \
  transit_operations_analytics_data.backup \
  2>&1 | tee restore.log
echo "Tables after restore"
psql --dbname=transit_operations_analytics_data --username=transportation2019 --command='\d+'
psql --dbname=transit_operations_analytics_data --username=transportation2019 --command='SELECT * FROM geometry_columns;'
