#! /bin/bash

# define parameters
export DBOWNER=transportation2019
export PGDATABASE=transit_operations_analytics_data

psql -U ${DBOWNER} -d ${PGDATABASE} -f passenger_stops.sql
psql -U ${DBOWNER} -d ${PGDATABASE} -f bus_trips.sql
psql -U ${DBOWNER} -d ${PGDATABASE} -f bus_all_stops.sql
