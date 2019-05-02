#! /bin/bash

# define parameters
export DBOWNER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export DEST=/csvs

echo "Creating the database backup"
pg_dump --format=p --clean --if-exists --create --compress=6 \
  --dbname=${PGDATABASE} > ${DEST}/${PGDATABASE}.sql.gz
pushd ${DEST}
sha512sum ${PGDATABASE}.sql.gz > ${PGDATABASE}.sql.gz.sha512sum
echo "Creating ERD"
postgresql_autodoc -d ${PGDATABASE} -t html
popd
