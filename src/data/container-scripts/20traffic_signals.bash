#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export RAW=/Raw

pushd ${RAW}
ogr2ogr -lco precision=NO -overwrite -t_srs EPSG:4326 \
  PG:"dbname=${PGDATABASE}" /vsizip/Traffic_Signals.zip
popd
