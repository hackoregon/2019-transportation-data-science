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

echo "Creating the table"
psql -f "trimet_stop_event.ddl"
echo "Loading the data"
export copy_command="\copy trimet_stop_event from '${interim}/tidy_trimet_stop_event.csv' with csv header"
/usr/bin/time psql -c "${copy_command}"

echo "Indexing timestamps"
/usr/bin/time psql -f "trimet_stop_event.timestamp"
echo "Geotagging"
/usr/bin/time psql -f "trimet_stop_event.geom"
echo "Creating pkey"
/usr/bin/time psql -f "trimet_stop_event.pkey"
echo "VACUUM ANALYZE"
/usr/bin/time psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
