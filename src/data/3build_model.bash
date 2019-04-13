#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f passenger_stops.sql
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f trips.sql
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f stops.sql
