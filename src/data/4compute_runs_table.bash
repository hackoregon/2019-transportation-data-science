#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

# loop over month codes
for month in y2017_m09 y2017_m10 y2017_m11 y2018_m04 y2018_m05
do
  /usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f compute_runs_table.sql \
 -v trimet_stop_event=${month}_trimet_stop_event -v runs_table=${month}_runs_table
done

echo "VACUUM ANALYZE"
psql -U ${DBOWNER} -d ${PGDATABASE} -c "VACUUM ANALYZE;"
