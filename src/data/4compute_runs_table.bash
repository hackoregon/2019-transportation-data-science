#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data
export PGPORT=5440

# loop over month codes
for schema in y2017_m09 y2017_m10 y2017_m11 y2018_m04 y2018_m05
do
  /usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f compute_runs_table.sql \
 -v schema=${schema}
done
