#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data

psql --username=${PGUSER} --dbname=${PGDATABASE} --file=bus_trips.sql
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=bus_passenger_stops.sql &
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=bus_all_stops.sql &
wait
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=rail_passenger_stops.sql
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=disturbance_stops.sql
