#! /bin/bash

# for PostgreSQL superuser connection you need to define these connection parameters
# export PGHOST=
# export PGPORT=
# export PGUSER=postgres
# export PGPASSWORD=

# define parameters
export DBOWNER=postgres
export PGDATABASE=transportation-systems-trimet-congestion

# create a fresh database
echo "Dropping and creating ${PGDATABASE} - you can ignore errors"
dropdb ${PGDATABASE} || true
createdb --owner=${DBOWNER} ${PGDATABASE}

echo "Restoring ${PGDATABASE} using ${JOBS} jobs"
/usr/bin/time pg_restore --jobs=${JOBS} --dbname=${PGDATABASE} --no-owner ${PGDATABASE}.backup
/usr/bin/time psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
