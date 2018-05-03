#! /bin/bash

# get connection details
source .env

# define parameters
export PGDATABASE=trimet_congestion

# tag the tables
for suffix in timestamp geom pkey
do
  for tablename in init_cyclic_v1h init_veh_stoph trimet_stop_event init_tripsh
  do
    psql -f "${tablename}.${suffix}" &
  done
  wait
done

echo "VACUUM ANALYZE"
psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
