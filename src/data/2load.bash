#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

sudo du -sh /var/lib/postgres/data
# create a fresh database with PostGIS extension
echo "Creating fresh database ${PGDATABASE} - ignore error if it doesn't exist"
dropdb ${PGDATABASE} || true
createdb --owner=${DBOWNER} ${PGDATABASE}
psql -U ${DBOWNER} -d ${PGDATABASE} -c "CREATE EXTENSION IF NOT EXISTS postgis;"

# load the raw data with SQL
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f load_raw_data.sql
sudo du -sh /var/lib/postgres/data
