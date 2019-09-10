#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export RAW=/Raw

pushd ${RAW}
ogr2ogr -overwrite -t_srs EPSG:4326 PG:"dbname=${PGDATABASE}" \
  busstop_catchment_zone_with_census_attribs.geojson
popd

echo "ridership_demographics.sql"
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=ridership_demographics.sql
