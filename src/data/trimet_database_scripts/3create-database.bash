#! /bin/bash

# get connection details
source .env

# define parameters
export interim="../../data/interim"
export external="../../data/external"
export DBOWNER=postgres
export PGDATABASE=transportation-systems-trimet

# create a fresh database
echo "Creating ${PGDATABASE} - ignore error if it doesn't exist"
dropdb ${PGDATABASE} || true
sudo mkdir -p /ssdpg
sudo chown -R postgres:postgres /ssdpg
psql -c "CREATE TABLESPACE ssdpg LOCATION '/ssdpg';"
createdb --owner=${DBOWNER} --tablespace=ssdpg ${PGDATABASE}
psql -d ${PGDATABASE} -c "CREATE EXTENSION postgis CASCADE;"

# import TriMet shapefiles
echo "Importing TriMet shapefiles"
pushd ${external}
export WHERE=https://developer.trimet.org/gis/data
psql -d ${PGDATABASE} -c "CREATE SCHEMA trimet_gis;"
for table in tm_boundary tm_parkride tm_rail_lines tm_rail_stops tm_routes tm_stops tm_route_stops tm_tran_cen
do
  echo "Importing $table"
  wget -nc -q $WHERE/$table.zip
  rm -fr $table; mkdir $table; cd $table
  unzip -qq ../$table.zip
  ogr2ogr -f PostgreSQL -lco PRECISION=NO -nlt PROMOTE_TO_MULTI \
    -lco SCHEMA=trimet_gis PG:"dbname=${PGDATABASE}" $table.shp
  cd ..
done
popd

echo "Creating the 'trimet_stop_events' table"
psql -d ${PGDATABASE} -f "trimet_stop_events.ddl"
echo "Loading the data"
export copy_command="\copy trimet_stop_events from '${interim}/trimet_stop_events.csv' with csv header"
/usr/bin/time psql -d ${PGDATABASE} -c "${copy_command}"




echo "VACUUM ANALYZE"
/usr/bin/time psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
