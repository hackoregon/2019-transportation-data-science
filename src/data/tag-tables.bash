#! /bin/bash

# get connection details
source .env

# define parameters
export PGDATABASE=trimet_congestion
psql -d ${PGDATABASE} -c "CREATE EXTENSION postgis;"

# tag the tables
for tablename in init_cyclic_v1h
do
  for suffix in geom timestamp index pkey
  do
    echo "Running ${tablename}.${suffix}"
    /usr/bin/time psql -f "${tablename}.${suffix}"
  done
done

echo "VACUUM ANALYZE"
psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
