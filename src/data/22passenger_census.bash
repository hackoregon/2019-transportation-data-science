#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data

# load the raw data with SQL
echo "passenger_census.sql"
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=passenger_census.sql
echo "master_stop_names.sql"
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=master_stop_names.sql
echo "ridership_change_tables.sql"
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=ridership_change_tables.sql
