#! /bin/bash

# define parameters
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data

psql --username=${PGUSER} --dbname=${PGDATABASE} --file=summary-statistics/passenger_stop_locations.sql
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=summary-statistics/system_wide_summary.sql
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=summary-statistics/by_stop_summary.sql
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=summary-statistics/rush_hour_summaries.sql
psql --username=${PGUSER} --dbname=${PGDATABASE} --file=summary-statistics/large_table_catalogs.sql
