#! /bin/bash

# define parameters
export DBOWNER=transportation2019
export PGDATABASE=transit_operations_analytics_data

psql -U ${DBOWNER} -d ${PGDATABASE} -f cleanup.sql
