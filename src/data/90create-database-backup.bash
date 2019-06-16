#! /bin/bash

# define parameters
export DBOWNER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export DEST=/csvs

echo "Creating the database backup"
pushd ${DEST}
/usr/bin/time pg_dump --verbose --format=c --exclude-schema=raw --dbname=${PGDATABASE} > ${PGDATABASE}.backup
sha512sum ${PGDATABASE}.backup > ${PGDATABASE}.backup.sha512sum
echo "Creating ERD"
postgresql_autodoc -d ${PGDATABASE} -t html \
--table=bus_all_stops,bus_passenger_stops,bus_trips,disturbance_stops,rail_passenger_stops,traffic_signals
popd
