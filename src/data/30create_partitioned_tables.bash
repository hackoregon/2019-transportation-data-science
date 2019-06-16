#! /bin/bash

# define parameters
export DBOWNER=transportation2019
export PGDATABASE=transit_operations_analytics_data

/usr/bin/time psql --username=${DBOWNER} --dbname=${PGDATABASE} --file=bus_trips.sql
/usr/bin/time psql --username=${DBOWNER} --dbname=${PGDATABASE} --file=bus_passenger_stops.sql
/usr/bin/time psql --username=${DBOWNER} --dbname=${PGDATABASE} --file=rail_passenger_stops.sql
/usr/bin/time psql --username=${DBOWNER} --dbname=${PGDATABASE} --file=bus_all_stops.sql
/usr/bin/time psql --username=${DBOWNER} --dbname=${PGDATABASE} --file=disturbance_stops.sql
