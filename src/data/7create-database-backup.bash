#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

echo "Creating the database backup"
pg_dump --format=p --clean --create --if-exists --dbname=${PGDATABASE} \
  | gzip -c > ~/Raw/${PGDATABASE}.sql.gz
