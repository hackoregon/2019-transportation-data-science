#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f create_tables.sql \
 -v init_veh_stoph=y2017_m09_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-30SEP2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f create_tables.sql \
 -v init_veh_stoph=y2017_m10_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-31OCT2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f create_tables.sql \
 -v init_veh_stoph=y2017_m11_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-30NOV2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f create_tables.sql \
 -v init_veh_stoph=y2018_m04_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-30APR2018.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f create_tables.sql \
 -v init_veh_stoph=y2018_m05_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-31MAY2018.csv'"
