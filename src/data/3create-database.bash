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
psql -c "CREATE EXTENSION postgis CASCADE;" -d ${PGDATABASE}

# load the tables
for tablename in trimet_stop_event
do
  psql -f "${tablename}.ddl"
  export copy_command="\copy ${tablename} from '${interim}/${tablename}.csv' with csv header"
  echo "Starting background load of table ${tablename}"
  /usr/bin/time psql -c "${copy_command}" &
done

echo "Waiting for table loads"
wait

echo "Converting timestamps"
/usr/bin/time psql -f "trimet_stop_event.timestamp"
echo "Geotagging"
/usr/bin/time psql -f "trimet_stop_event.geom"
echo "Creating pkey"
/usr/bin/time psql -f "trimet_stop_event.pkey"
echo "VACUUM ANALYZE"
/usr/bin/time psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
