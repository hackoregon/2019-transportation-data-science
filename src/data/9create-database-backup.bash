#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data
export DEST=/csvs

echo "Vacuuming the database"
psql -U ${DBOWNER} -d ${PGDATABASE} -c "VACUUM ANALYZE;"
echo "Creating the database backup"
pg_dump --format=p --clean --if-exists --create --compress=6 \
  --dbname=${PGDATABASE} > ${DEST}/${PGDATABASE}.sql.gz
pushd ${DEST}
sha512sum ${PGDATABASE}.sql.gz > ${PGDATABASE}.sql.gz.sha512sum
popd
