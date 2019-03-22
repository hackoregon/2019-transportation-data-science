#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

echo "Creating date stamps"
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f fix_dates.sql
echo "Creating geometry columns"
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f geometry_columns.sql
