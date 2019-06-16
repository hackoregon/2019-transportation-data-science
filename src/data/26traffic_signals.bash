#! /bin/bash

# define parameters
export DBOWNER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export RAW=/Raw

pushd ${RAW}
echo "Download traffic signals shapefile from https://gis-pdx.opendata.arcgis.com/datasets/traffic-signals"
echo "Save in ${RAW}"
read -ep "Press 'Enter' here after file is downloaded"
ogr2ogr -lco precision=NO -overwrite -t_srs EPSG:4326 \
  PG:"user=${DBOWNER} active_schema=public" /vsizip/Traffic_Signals.zip
popd
