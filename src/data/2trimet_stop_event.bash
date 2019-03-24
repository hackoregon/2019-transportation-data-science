#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data
export PGPORT=5440

# create a fresh database with PostGIS extension
echo "Creating fresh database ${PGDATABASE} - ignore error if it doesn't exist"
dropdb ${PGDATABASE} || true
createdb --owner=${DBOWNER} ${PGDATABASE}
echo "Creating 'postgis' extension"
psql -U ${DBOWNER} -d ${PGDATABASE} -c "CREATE EXTENSION postgis CASCADE;"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f trimet_stop_event.sql \
 -v schema=y2017_m09 -v trimet_stop_event_csv="'/csvs/trimet_stop_event 1-30SEP2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f trimet_stop_event.sql \
 -v schema=y2017_m10 -v trimet_stop_event_csv="'/csvs/trimet_stop_event 1-31OCT2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f trimet_stop_event.sql \
 -v schema=y2017_m11 -v trimet_stop_event_csv="'/csvs/trimet_stop_event 1-30NOV2017.csv'"
