#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data
export DEST=/csvs

echo "Vacuuming the database"
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -c "VACUUM ANALYZE;"
echo "Creating the database backup"
/usr/bin/time pg_dump --format=c --dbname=${PGDATABASE} \
  > ${DEST}/${PGDATABASE}.backup
pushd ${DEST}
sha512sum ${PGDATABASE}.backup > ${PGDATABASE}.backup.sha512sum
popd
