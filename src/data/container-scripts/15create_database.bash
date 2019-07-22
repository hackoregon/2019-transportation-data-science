#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data

# create a fresh database with PostGIS extension
echo "Creating database superuser ${PGUSER} - ignore error if user already exists"
psql --username=postgres --dbname=postgres --command="CREATE USER ${PGUSER} WITH PASSWORD '${PGPASSWORD}' SUPERUSER;"
echo "Creating fresh database ${PGDATABASE} with PostGIS extension - ignore error if it doesn't exist"
psql --username=postgres --dbname=postgres --command="DROP DATABASE IF EXISTS ${PGDATABASE};"
psql --username=postgres --dbname=postgres --command="CREATE DATABASE ${PGDATABASE} WITH OWNER ${PGUSER};"
psql --username=${PGUSER} --dbname=${PGDATABASE} --command="CREATE EXTENSION IF NOT EXISTS postgis;"
psql --username=${PGUSER} --dbname=${PGDATABASE} --command="CREATE SCHEMA IF NOT EXISTS raw;"
