#! /bin/bash

export PGHOST=localhost
export PGPORT=5439
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data
export DEST=${PWD}
psql --command "\d+"
psql --command "DELETE FROM bus_trips WHERE date_part('month', opd_date) != 9;"
psql --command "DELETE FROM bus_all_stops WHERE date_part('month', opd_date) != 9;"
psql --command "DELETE FROM bus_passenger_stops WHERE date_part('month', service_date) != 9;"
psql --command "DELETE FROM rail_passenger_stops WHERE date_part('month', service_date) != 9;"
psql --command "\d+"
echo "Creating the database backup"
pg_dump --format=c --dbname=${PGDATABASE} > ${DEST}/tadpole.backup
pushd ${DEST}
sha512sum tadpole.backup > tadpole.backup.sha512sum
popd
