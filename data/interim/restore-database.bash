#! /bin/bash

# for PostgreSQL superuser connection you need to define the connection parameters outside this script
# export PGHOST=
# export PGPORT=
# export PGUSER=postgres
# export PGPASSWORD=

# define parameters
export DBOWNER=postgres
export PGDATABASE=trimet_congestion
export JOBS=7 # one less than your processor / thread count - a four-core / eight-thread would use seven

# create a fresh database
echo "Dropping and creating ${PGDATABASE} - you can ignore errors"
dropdb ${PGDATABASE} || true
createdb --owner=${DBOWNER} ${PGDATABASE}

echo "Restoring ${PGDATABASE} using ${JOBS} jobs"
/usr/bin/time pg_restore --jobs=${JOBS} --dbname=${PGDATABASE} --no-owner trimet_congestion.backup
/usr/bin/time psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
