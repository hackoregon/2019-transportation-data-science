#! /bin/bash

/usr/bin/time pg_dump \
  --port=5440 \
  --format=p \
  --verbose \
  --dbname=transit_operations_analytics_data \
  | gzip -c > transit_operations_analytics_data.sql.gz
