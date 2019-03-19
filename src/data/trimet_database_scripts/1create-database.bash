#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

# create a fresh database
echo "Creating fresh database ${PGDATABASE} - ignore error if it doesn't exist"
dropdb ${PGDATABASE} || true
createdb --owner=${DBOWNER} ${PGDATABASE}
psql -U ${DBOWNER} -d ${PGDATABASE} -c "CREATE EXTENSION postgis CASCADE;"
