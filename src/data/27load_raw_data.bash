#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export DEST=/Work

# load the raw data with SQL
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=load_raw_stop_event.sql
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=load_raw_tripsh.sql
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=load_raw_veh_stoph.sql

echo "Creating raw database backup"
pushd ${DEST}
pg_dump --verbose --format=c --dbname=${PGDATABASE} > ${PGDATABASE}_raw.backup
pg_restore --list ${PGDATABASE}_raw.backup
sha512sum ${PGDATABASE}_raw.backup > ${PGDATABASE}_raw.backup.sha512sum
popd
