#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export RAW=/Raw

echo "Creating schemas"
for schema in trimet_gis census_gis
do
  echo "Creating schema ${schema}"
  psql --username=${PGUSER} --dbname=${PGDATABASE} --command="DROP SCHEMA IF EXISTS ${schema} CASCADE;"
  psql --username=${PGUSER} --dbname=${PGDATABASE} --command="CREATE SCHEMA ${schema};"
done

pushd ${RAW}
echo "Importing TriMet shapefiles"
export WHERE="https://developer.trimet.org/gis/data"
for i in \
  ${WHERE}/tm_boundary.zip \
  ${WHERE}/tm_parkride.zip \
  ${WHERE}/tm_rail_lines.zip \
  ${WHERE}/tm_rail_stops.zip \
  ${WHERE}/tm_route_stops.zip \
  ${WHERE}/tm_routes.zip \
  ${WHERE}/tm_stops.zip \
  ${WHERE}/tm_tran_cen.zip
do
  echo $i
  wget --no-clobber --quiet $i
done

for i in tm*zip
do
  echo $i
  if [ "$i" == "tm_routes.zip" ]
  then
    ogr2ogr -lco precision=NO -nlt PROMOTE_TO_MULTI -overwrite -t_srs EPSG:4326 \
      PG:"dbname=${PGDATABASE} active_schema=trimet_gis" /vsizip/$i
  else
    ogr2ogr -lco precision=NO -overwrite -t_srs EPSG:4326 \
      PG:"dbname=${PGDATABASE} active_schema=trimet_gis" /vsizip/$i
  fi
done

echo "Importing TIGER/Line® shapefiles"
export WHERE="https://www2.census.gov/geo/tiger/TIGER2019"
for i in \
  ${WHERE}/TABBLOCK/tl_2019_41_tabblock10.zip \
  ${WHERE}/BG/tl_2019_41_bg.zip \
  ${WHERE}/TRACT/tl_2019_41_tract.zip \
  ${WHERE}/TABBLOCK/tl_2019_53_tabblock10.zip \
  ${WHERE}/BG/tl_2019_53_bg.zip \
  ${WHERE}/TRACT/tl_2019_53_tract.zip
do
  echo $i
  wget --no-clobber --quiet $i
done

for i in tl*zip
do
  echo $i
  ogr2ogr -lco precision=NO -nlt PROMOTE_TO_MULTI -overwrite -t_srs EPSG:4326 \
    PG:"dbname=${PGDATABASE} active_schema=census_gis" /vsizip/$i
done
popd

echo "Creating census_tract_boundaries"
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=census_tract_boundaries.sql
