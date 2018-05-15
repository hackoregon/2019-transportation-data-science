#! /bin/bash

export EXTERNAL=../../data/external
export WHERE=https://developer.trimet.org/gis/data
psql -d transportation-systems-trimet -c "DROP SCHEMA IF EXISTS trimet_gis CASCADE;"
psql -d transportation-systems-trimet -c "CREATE SCHEMA trimet_gis;"

pushd $EXTERNAL
for table in tm_boundary tm_parkride tm_rail_lines tm_rail_stops tm_routes tm_stops tm_route_stops tm_tran_cen
do
  wget -nc -q $WHERE/$table.zip
  cp $table.zip $HOME/Raw/
  rm -fr $table; mkdir $table; cd $table
  unzip ../$table.zip
  ogr2ogr -f PostgreSQL -lco PRECISION=NO -nlt PROMOTE_TO_MULTI \
    -lco SCHEMA=trimet_gis PG:"dbname=transportation-systems-trimet" $table.shp
  cd ..
done
popd
