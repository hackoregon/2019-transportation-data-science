#! /bin/bash

# define parameters
export interim="../../data/interim"
export PGDATABASE=trimet_congestion
export JOBS=7 # one less than your processor / thread count - a four-core / eight-thread would use seven

/usr/bin/time pg_dump --format=directory --jobs=${JOBS} \
  --file=${interim}/trimet_congestion.backup $PGDATABASE
