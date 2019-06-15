#! /bin/bash

# define parameters
export DBOWNER=transportation2019
export PGDATABASE=transit_operations_analytics_data

#/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f bus_passenger_stops.sql
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f rail_passenger_stops.sql
#/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f bus_trips.sql
#/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f bus_all_stops.sql
#/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f disturbance_stops.sql
