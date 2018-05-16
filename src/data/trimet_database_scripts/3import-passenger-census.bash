#! /bin/bash

# define parameters
export DBOWNER=transportation-systems
export PGDATABASE=transportation-systems-main

echo "Creating the 'passenger_census' (ridership data) table"
/usr/bin/time psql -f passenger-census.psql
