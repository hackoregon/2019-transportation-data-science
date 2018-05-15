#! /bin/bash

# define parameters
export DBOWNER=transportation-systems
export PGDATABASE=transportation-systems-trimet

# create a fresh database
echo "Creating ${PGDATABASE} - ignore error if it doesn't exist"
dropdb ${PGDATABASE} || true
createdb --owner=${DBOWNER} ${PGDATABASE}
psql -d ${PGDATABASE} -c "CREATE EXTENSION postgis CASCADE;"

# import TriMet shapefiles
echo "Importing TriMet shapefiles"
pushd ~/Raw
export WHERE=https://developer.trimet.org/gis/data
for table in tm_boundary tm_parkride tm_rail_lines tm_rail_stops tm_routes tm_stops tm_route_stops tm_tran_cen
do
  echo "Importing $table"
  wget -nc -q $WHERE/$table.zip
  rm -fr $table; mkdir $table; cd $table
  unzip -qq ../$table.zip
  ogr2ogr -f PostgreSQL -lco PRECISION=NO -nlt PROMOTE_TO_MULTI \
    PG:"dbname=${PGDATABASE}" $table.shp
  cd ..
done
popd

echo "Creating the 'passenger_census' (ridership data) table"
psql -f passenger-census.psql

echo "Creating the 'trimet_stop_events' table"

pushd ~/Raw
echo "Unpacking the archive"
/usr/bin/time 7z e -y scrapes.rar
popd

psql -d ${PGDATABASE} -f "trimet_stop_events.ddl"
echo "Loading the data"
export copy_command="\copy trimet_stop_events from '${interim}/trimet_stop_events.csv' with csv header"
/usr/bin/time psql -d ${PGDATABASE} -c "${copy_command}"




echo "VACUUM ANALYZE"
/usr/bin/time psql -d ${PGDATABASE} -c "VACUUM ANALYZE;"
