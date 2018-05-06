#! /bin/bash

# get connection details
source .env

# define parameters
export interim="../../data/interim"
export DBOWNER=postgres
export PGDATABASE=trimet_congestion

# create a fresh database
echo "Creating ${PGDATABASE} - ignore error if it doesn't exist"
dropdb ${PGDATABASE} || true
sudo mkdir -p /ssdpg
sudo chown -R postgres:postgres /ssdpg
psql -c "CREATE TABLESPACE ssdpg LOCATION '/ssdpg';"
createdb --owner=${DBOWNER} --tablespace=ssdpg ${PGDATABASE}

# load the tables
for tablename in init_cyclic_v1h init_veh_stoph trimet_stop_event init_tripsh
do
  psql -f "${tablename}.ddl"
  export copy_command="\copy ${tablename} from '${interim}/${tablename}.csv' with csv"
  echo "Starting background load of table ${tablename}"
  /usr/bin/time psql -c "${copy_command}" &
done

echo "Waiting for table loads"
wait
echo "VACUUM ANALYZE"
/usr/bin/time psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"

export JOBS=7 # one less than your processor / thread count - a four-core / eight-thread would use seven

echo "Removing previous backup directory if any"
rm -fr ${interim}/trimet_congestion.backup
echo "Making a backup"
/usr/bin/time pg_dump --format=directory --jobs=${JOBS} \
  --file=${interim}/trimet_congestion.backup ${PGDATABASE}
pg_restore --list ${interim}/trimet_congestion.backup
