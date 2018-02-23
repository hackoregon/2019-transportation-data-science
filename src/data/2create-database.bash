#! /bin/bash

# define parameters
export interim="../../data/interim"
export PGDATABASE=trimet_congestion

# create a fresh database
dropdb ${PGDATABASE} || true
sudo du -sh /var/lib/postgres/data # size before loading data
createdb ${PGDATABASE}

# load the tables
for tablename in init_cyclic_v1h init_veh_stoph trimet_stop_event init_tripsh
do
  psql -f "${tablename}.ddl"
  export copy_command="\copy ${tablename} from '${interim}/${tablename}.csv' with csv"
  echo ${copy_command}
  /usr/bin/time psql -c "${copy_command}" 2>&1 | tee ${tablename}.log &
done

# measure size after we load data
wait
sudo du -sh /var/lib/postgres/data
