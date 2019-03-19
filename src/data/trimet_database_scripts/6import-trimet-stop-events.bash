#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

echo "Importing the CSVs to PostGIS"
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f copy_tables.sql
