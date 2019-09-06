#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data

psql --username=${PGUSER} --dbname=${PGDATABASE} --file=rail_passenger_stops.sql
