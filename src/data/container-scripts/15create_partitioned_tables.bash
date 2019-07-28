#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data

# create empty partitioned tables
psql --username=${PGUSER} --dbname=${PGDATABASE} --file="create_partitioned_tables.sql"
