#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export DEST=/Work

echo "Creating the database backup"
pushd ${DEST}
pg_dump --verbose --clean --if-exists --no-owner --schema=census_gis --dbname=${PGDATABASE} \
  | gzip -c > census_gis.sql.gz
sha512sum census_gis.sql.gz > census_gis.sql.gz.sha512sum
popd
