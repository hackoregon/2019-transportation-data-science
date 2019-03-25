#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data
export PGPORT=5440
export DEST=/csvs

echo "Vacuuming the database"
sudo du -sh /var/lib/postgres/data/
/usr/bin/time psql -U ${DBOWNER} -d ${PGDATABASE} -c "VACUUM ANALYZE;"
sudo du -sh /var/lib/postgres/data/
echo "Creating the database backup"
/usr/bin/time pg_dump --format=p --clean --if-exists --create --dbname=${PGDATABASE} | gzip -dc \
  > ${DEST}/${PGDATABASE}.sql.gz
