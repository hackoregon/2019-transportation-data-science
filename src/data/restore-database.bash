#! /bin/bash

# for PostgreSQL superuser connection you need to define the connection parameters outside this script
# export PGHOST=
# export PGPORT=
# export PGUSER=postgres
# export PGPASSWORD=

# define parameters
export interim="../../data/interim"
export DBOWNER=postgres
export PGDATABASE=trimet_congestion
export JOBS=7 # one less than your processor / thread count - a four-core / eight-thread would use seven

# create a fresh database
dropdb ${PGDATABASE} || true
sudo du -sh /var/lib/postgres/data # size before loading data
createdb --owner=${DBOWNER} ${PGDATABASE}

pg_restore --jobs=${JOBS} --dbname=${PGDATABASE} --no-owner \
  ${interim}/trimet_congestion.backup
psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
