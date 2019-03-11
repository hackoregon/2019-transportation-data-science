#! /bin/bash

/usr/bin/time pg_dump \
  --file=transit_operations_analytics_data.sql \
  --format=p \
  --verbose \
  --dbname=transit_operations_analytics_data
