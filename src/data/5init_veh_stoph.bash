#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data
export PGPORT=5440
psql -U ${DBOWNER} -d ${PGDATABASE} -c "DROP SCHEMA IF EXISTS init_veh_stoph CASCADE;"
psql -U ${DBOWNER} -d ${PGDATABASE} -c "CREATE SCHEMA init_veh_stoph;"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_veh_stoph.sql \
 -v init_veh_stoph=y2017_m09_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-30SEP2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_veh_stoph.sql \
 -v init_veh_stoph=y2017_m10_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-31OCT2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_veh_stoph.sql \
 -v init_veh_stoph=y2017_m11_init_veh_stoph -v init_veh_stoph_csv="'/csvs/init_veh_stoph 1-30NOV2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_tripsh.sql \
 -v init_tripsh=y2017_m09_init_tripsh -v init_tripsh_csv="'/csvs/init_tripsh 1-30SEP2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_tripsh.sql \
 -v init_tripsh=y2017_m10_init_tripsh -v init_tripsh_csv="'/csvs/init_tripsh 1-31OCT2017.csv'"

/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_tripsh.sql \
 -v init_tripsh=y2017_m11_init_tripsh -v init_tripsh_csv="'/csvs/init_tripsh 1-30NOV2017.csv'"
