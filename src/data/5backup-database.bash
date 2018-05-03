#! /bin/bash

# get connection details
source .env

# define parameters
export interim="../../data/interim"
export PGDATABASE=trimet_congestion
export JOBS=7 # one less than your processor / thread count - a four-core / eight-thread would use seven

# using 9.6 dump program!
export PATH=/d/opt/PostgreSQL/9.6/bin/:$PATH
pg_dump --format=directory --jobs=${JOBS} \
  --file=${interim}/trimet_congestion.backup ${PGDATABASE}
