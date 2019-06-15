#! /bin/bash

export BACKUP_PATH=/csvs
pushd ${BACKUP_PATH}

echo "Creating user and database with PostGIS as database superuser"
sudo su - postgres -c "dropdb transit_operations_analytics_data"
sudo su - postgres -c "dropuser transportation2019"
sudo su - postgres -c "createuser transportation2019"
sudo su - postgres -c "createdb --owner=transportation2019 transit_operations_analytics_data"
sudo su - postgres -c "psql -d transit_operations_analytics_data -c 'CREATE EXTENSION postgis;'"

echo "Checksumming backup file"
sha512sum -c transit_operations_analytics_data.backup.sha512sum
echo "Restoring database as ordinary user - ignore error when it tries to create extension"
pg_restore --verbose --dbname=transit_operations_analytics_data --username=transportation2019 \
  transit_operations_analytics_data.backup
sudo su - postgres -c "psql -d transit_operations_analytics_data -c '\dS+'"

popd
