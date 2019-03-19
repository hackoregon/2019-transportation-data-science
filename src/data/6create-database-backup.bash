#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data
export DEST=/csvs

echo "Creating the database backup"
pg_dump --format=p --clean --create --if-exists --dbname=${PGDATABASE} \
  | gzip -c > ${DEST}/${PGDATABASE}.sql.gz
