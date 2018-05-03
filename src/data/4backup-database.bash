#! /bin/bash

# for PostgreSQL superuser connection you need to define the connection parameters outside this script
export PGHOST=localhost
export PGPORT=5439
export PGUSER=postgres
export PGPASSWORD=some.string.you.can.remember.that.nobody.else.can.guess

# define parameters
export interim="../../data/interim"
export PGDATABASE=trimet_congestion
export JOBS=7 # one less than your processor / thread count - a four-core / eight-thread would use seven

time pg_dump --format=directory --jobs=${JOBS} \
  --file=${interim}/trimet_congestion.backup ${PGDATABASE}
