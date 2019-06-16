#! /bin/bash

echo "Checking connection variables"
if [ "$PGHOST" = "" ]
then
  echo "Define PGHOST and re-run!"
  exit -1
fi
if [ "$PGPORT" = "" ]
then
  echo "Define PGPORT and re-run!"
  exit -1
fi
if [ "$PGPASSWORD" = "" ]
then
  echo "Define PGPASSWORD and re-run!"
  exit -1
fi

# define parameters
export DBOWNER=transportation2019
export PGDATABASE=transit_operations_analytics_data

# create a fresh database with PostGIS extension
echo "Creating database superuser ${DBOWNER} - ignore error if user already exists"
psql --username=postgres --dbname=postgres --command="CREATE USER ${DBOWNER} WITH PASSWORD '${PGPASSWORD}' SUPERUSER;"
echo "Creating fresh database ${PGDATABASE} with PostGIS extension - ignore error if it doesn't exist"
psql --username=postgres --dbname=postgres --command="DROP DATABASE IF EXISTS ${PGDATABASE};"
psql --username=postgres --dbname=postgres --command="CREATE DATABASE ${PGDATABASE} WITH OWNER ${DBOWNER};"
psql --username=${DBOWNER} --dbname=${PGDATABASE} --command="CREATE EXTENSION IF NOT EXISTS postgis;"

# load the raw data with SQL
/usr/bin/time psql --username=${DBOWNER} --dbname=${PGDATABASE} --file=load_raw_data.sql
