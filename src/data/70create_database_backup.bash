#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export DEST=/Work

echo "Cleaning up database"
psql --username=${PGUSER} --dbname=${PGDATABASE} --command="DROP SCHEMA IF EXISTS raw CASCADE;"
psql --username=${PGUSER} --dbname=${PGDATABASE} --command="DROP TABLE IF EXISTS bus_all_stops CASCADE;"
/usr/bin/time psql --username=${PGUSER} --dbname=${PGDATABASE} --command="VACUUM ANALYZE;"
echo "Creating the database backup"
pushd ${DEST}
pg_dump --verbose --format=c --exclude-schema=raw --dbname=${PGDATABASE} > ${PGDATABASE}.backup
pg_restore --list ${PGDATABASE}.backup
sha512sum ${PGDATABASE}.backup > ${PGDATABASE}.backup.sha512sum
popd
