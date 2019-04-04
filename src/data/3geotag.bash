#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

echo "Geotagging init_veh_stopsh"
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f geotag_init_veh_stoph.sql
