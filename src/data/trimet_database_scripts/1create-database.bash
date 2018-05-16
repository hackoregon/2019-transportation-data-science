#! /bin/bash

# define parameters
export DBOWNER=transportation-systems
export PGDATABASE=transportation-systems-main

# create a fresh database
echo "Creating database user ${DBOWNER} - ignore error if it already exists"
createuser ${DBOWNER} || true
echo "Creating fresh database ${PGDATABASE} - ignore error if it doesn't exist"
dropdb ${PGDATABASE} || true
createdb --owner=${DBOWNER} ${PGDATABASE}
psql -U ${DBOWNER} -d ${PGDATABASE} -c "CREATE EXTENSION postgis CASCADE;"
