#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data
export PGPORT=5440

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_veh_stoph.sql \
 -v schema=y2017_m09 -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-30SEP2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_veh_stoph.sql \
 -v schema=y2017_m10 -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-31OCT2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_veh_stoph.sql \
 -v schema=y2017_m11 -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-30NOV2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_tripsh.sql \
 -v schema=y2017_m09 -v init_tripsh_csv="'/csvs/init_tripsh 1-30SEP2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_tripsh.sql \
 -v schema=y2017_m10 -v init_tripsh_csv="'/csvs/init_tripsh 1-31OCT2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_tripsh.sql \
 -v schema=y2017_m11 -v init_tripsh_csv="'/csvs/init_tripsh 1-30NOV2017.csv'"
