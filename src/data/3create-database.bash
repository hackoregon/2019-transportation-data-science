#! /bin/bash

# get connection details
source .env

# define parameters
export interim="../../data/interim"
export DBOWNER=postgres
export PGDATABASE=trimet_congestion

# create a fresh database
dropdb ${PGDATABASE} || true
createdb --owner=${DBOWNER} ${PGDATABASE}

# load the tables
for tablename in init_cyclic_v1h init_veh_stoph trimet_stop_event init_tripsh
do
  psql -f "${tablename}.ddl"
  export copy_command="\copy ${tablename} from '${interim}/${tablename}.csv' with csv"
  psql -c "${copy_command}" &
done

# measure size after we load data
wait
psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
