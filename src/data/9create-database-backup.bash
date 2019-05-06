#! /bin/bash

# define parameters
export DBOWNER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export DEST=/csvs

echo "Creating the database backup"
pg_dump --format=c --dbname=${PGDATABASE} > ${DEST}/${PGDATABASE}.backup
pushd ${DEST}
sha512sum ${PGDATABASE}.backup > ${PGDATABASE}.backup.sha512sum
echo "Creating ERD"
postgresql_autodoc -d ${PGDATABASE} -t html
popd
