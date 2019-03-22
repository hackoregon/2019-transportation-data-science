#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

# create a fresh database with PostGIS extension
echo "Creating fresh database ${PGDATABASE} - ignore error if it doesn't exist"
dropdb ${PGDATABASE} || true
createdb --owner=${DBOWNER} ${PGDATABASE}
echo "Creating 'postgis' extension"
psql -U ${DBOWNER} -d ${PGDATABASE} -c "CREATE EXTENSION postgis CASCADE;"

psql -U ${DBOWNER} -d ${PGDATABASE} -f create_tables.sql \
 -v init_veh_stoph=y2017_m09_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-30SEP2017.csv'" \
 -v trimet_stop_event=y2017_m09_trimet_stop_event -v trimet_stop_event_csv="'/csvs/trimet_stop_event 1-30SEP2017.csv'"

psql -U ${DBOWNER} -d ${PGDATABASE} -f create_tables.sql \
 -v init_veh_stoph=y2017_m10_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-31OCT2017.csv'" \
 -v trimet_stop_event=y2017_m10_trimet_stop_event -v trimet_stop_event_csv="'/csvs/trimet_stop_event 1-31OCT2017.csv'"

psql -U ${DBOWNER} -d ${PGDATABASE} -f create_tables.sql \
 -v init_veh_stoph=y2017_m11_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-30NOV2017.csv'" \
 -v trimet_stop_event=y2017_m11_trimet_stop_event -v trimet_stop_event_csv="'/csvs/trimet_stop_event 1-30NOV2017.csv'"
