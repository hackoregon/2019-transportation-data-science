#! /bin/bash

export BACKUP_PATH=/Work
pushd ${BACKUP_PATH}

echo "Creating user and database with PostGIS as database superuser"
sudo su - postgres -c "dropdb transit_operations_analytics_data"
sudo su - postgres -c "dropuser transportation2019"
psql --command="CREATE USER transportation2019 WITH PASSWORD '${PGPASSWORD}' SUPERUSER;"
sudo su - postgres -c "createdb --owner=transportation2019 transit_operations_analytics_data"
sudo su - postgres -c "psql -d transit_operations_analytics_data -c 'CREATE EXTENSION postgis;'"
sudo su - postgres -c "psql -d transit_operations_analytics_data -c 'CREATE EXTENSION pg_stat_statements;'"

echo "Checksumming backup file"
sha512sum -c transit_operations_analytics_data_raw.backup.sha512sum
echo "Restoring database - ignore errors when it tries to create PostGIS extension"
/usr/bin/time pg_restore --jobs=1 --clean --if-exists --verbose \
  --dbname=transit_operations_analytics_data --username=transportation2019 \
  transit_operations_analytics_data_raw.backup 2>&1 | tee restore.log

popd
