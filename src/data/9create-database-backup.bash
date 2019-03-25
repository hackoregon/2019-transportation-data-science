#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data
export DEST=/csvs

echo "Vacuuming the database"
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -c "VACUUM ANALYZE;"
echo "Creating the database backup"
/usr/bin/time pg_dump --format=p --clean --if-exists --create --dbname=${PGDATABASE} | gzip -c \
  > ${DEST}/${PGDATABASE}.sql.gz
pushd ${DEST}
sha512sum ${PGDATABASE}.sql.gz > ${PGDATEBASE}.sql.gz.sha512sum
gzip -dc ${PGDATABASE}.sql.gz | wc -c
popd
