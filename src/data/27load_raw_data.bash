#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data

# load the raw data with SQL
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=load_raw_stop_event.sql &
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=load_raw_tripsh.sql &
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=load_raw_veh_stoph.sql &
wait
