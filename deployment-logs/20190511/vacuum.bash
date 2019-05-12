#! /bin/bash

echo "Starting perf log"
rm -f vaccsarlog.bin
sar -o vaccsarlog.bin 10 999999999 > /dev/null 2>&1 &
echo "Vacuuming"
date
/usr/bin/time psql \
  --dbname=transit_operations_analytics_data \
  --username=transportation2019 \
  --command="VACUUM VERBOSE ANALYZE;" \
  2>&1 | tee vacuum.log
date
echo "Formatting perf log"
kill %1
sar -A -f vaccsarlog.bin > vaccsarlog.txt
