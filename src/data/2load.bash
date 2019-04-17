#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

# create a fresh database with PostGIS extension
echo "Creating fresh database ${PGDATABASE} - ignore error if it doesn't exist"
dropdb ${PGDATABASE} || true
createdb --owner=${DBOWNER} ${PGDATABASE}
psql -U ${DBOWNER} -d ${PGDATABASE} -c "CREATE EXTENSION IF NOT EXISTS postgis;"

for sqlfile in create_*.sql
do
  psql -U ${DBOWNER} -d ${PGDATABASE} -f ${sqlfile}
done

for csvdate in 1-30SEP2017 1-31OCT2017 1-30NOV2017
do
  echo ${csvdate}

  psql -U ${DBOWNER} -d ${PGDATABASE} -f load_trimet_stop_event.sql \
  -v csvfile="'/csvs/trimet_stop_event ${csvdate}.csv'"
  psql -U ${DBOWNER} -d ${PGDATABASE} -f load_init_tripsh.sql \
  -v csvfile="'/csvs/init_tripsh ${csvdate}.csv'"
  psql -U ${DBOWNER} -d ${PGDATABASE} -f load_init_veh_stoph.sql \
  -v csvfile="'/csvs/init_veh_stoph ${csvdate}.csv'"
done
