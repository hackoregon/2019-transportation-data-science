#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data

# load the raw data with SQL
/usr/bin/time psql --username=${PGUSER} --dbname=${PGDATABASE} --file=load_raw_stop_event.sql &
/usr/bin/time psql --username=${PGUSER} --dbname=${PGDATABASE} --file=load_raw_tripsh.sql &
/usr/bin/time psql --username=${PGUSER} --dbname=${PGDATABASE} --file=load_raw_veh_stoph.sql &
wait
