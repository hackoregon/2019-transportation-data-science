#! /bin/bash

echo "Starting perf log"
rm -f sarlog.bin
sar -o sarlog.bin 60 999999999 > /dev/null 2>&1 &
echo "Fetching backup from S3"
date
/usr/bin/time aws s3 cp \
  ${BACKUP_BUCKET}/transit_operations_analytics_data.backup \
  .
date
echo "Restoring database as ordinary user - ignore error when it tries to create extension"
/usr/bin/time pg_restore --verbose --clean --if-exists \
  --dbname=transit_operations_analytics_data \
  --username=transportation2019 \
  transit_operations_analytics_data.backup \
  2>&1 | tee pg_restore.log
date
echo "Tables after restore"
psql --dbname=transit_operations_analytics_data --username=transportation2019 --command='\d+'
psql --dbname=transit_operations_analytics_data --username=transportation2019 --command='SELECT * FROM geometry_columns;'
echo "Formatting perf log"
kill %1
sar -A -f sarlog.bin > sarlog.txt
