#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export RAW=/Raw
export WORK=/Work

pushd ${RAW}
sha512sum -c long_format_lodes_data.zip.sha512sum
popd

pushd ${WORK}
rm -fr LODES
unzip ${RAW}/long_format_lodes_data.zip
popd
psql --username=${PGUSER} --dbname=${PGDATABASE} --file="lodes_od.sql"
