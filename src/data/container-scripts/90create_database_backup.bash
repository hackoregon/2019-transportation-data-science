#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export DEST=/Work

#echo "Vacuuming the database"
#/usr/bin/time psql --username=${PGUSER} --dbname=${PGDATABASE} --command="VACUUM ANALYZE;"
echo "Creating the database backup"
pushd ${DEST}
/usr/bin/time pg_dump --format=c --exclude-schema=raw --dbname=${PGDATABASE} > ${PGDATABASE}.backup
pg_restore --list ${PGDATABASE}.backup
sha512sum ${PGDATABASE}.backup > ${PGDATABASE}.backup.sha512sum
echo "Creating ERD"
postgresql_autodoc -d ${PGDATABASE} -t html \
--table=bus_all_stops,bus_passenger_stops,bus_trips,disturbance_stops,rail_passenger_stops,traffic_signals
popd
