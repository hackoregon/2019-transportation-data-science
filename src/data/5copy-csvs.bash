#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

echo "Creating the tables"
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f create_tables.sql
echo "Copying the CSVs to PostGIS"
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f copy_tables.sql
