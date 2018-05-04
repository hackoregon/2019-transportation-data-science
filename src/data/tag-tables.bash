#! /bin/bash

# get connection details
source .env

# define parameters
export PGDATABASE=trimet_congestion

# tag the tables
for tablename in init_cyclic_v1h
do
  for suffix in timestamp geom pkey
  do
    echo "Running ${tablename}.${suffix} in the background"
    psql -f "${tablename}.${suffix}" &
  done
  echo "Waiting for background jobs"
  wait
done

echo "VACUUM ANALYZE"
psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
