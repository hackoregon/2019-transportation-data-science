#! /bin/bash

echo "Creating the database backup"
pg_dump --format=p --verbose --clean --create --if-exists --dbname=transportation-systems-trimet \
  | gzip -c > ~/Raw/transportation-systems-trimet.sql.gz
