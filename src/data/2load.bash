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

for code in 1-30SEP2017:m201709 1-31OCT2017:m201710 1-30NOV2017:m201711 1-30APR2018:m201804 1-31MAY2018:m201805
do
  schema=`echo $code|sed 's/^.*://'`
  csvdate=`echo $code|sed 's/:.*$//'`
  echo ${schema} ${csvdate}

  /usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f trimet_stop_event.sql \
  -v schema=${schema} -v csvfile="'/csvs/trimet_stop_event ${csvdate}.csv'"
  /usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_tripsh.sql \
  -v schema=${schema} -v csvfile="'/csvs/init_tripsh ${csvdate}.csv'"
  /usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -f init_veh_stoph.sql \
  -v schema=${schema} -v csvfile="'/csvs/init_veh_stoph ${csvdate}.csv'"
done
