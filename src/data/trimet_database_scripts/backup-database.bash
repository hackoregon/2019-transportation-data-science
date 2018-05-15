#! /bin/bash

# get connection details
source .env

# define parameters
export interim="../../data/interim"
export PGDATABASE=transportation-systems-trimet-congestion

echo "Removing previous backup if any"
rm -fr ${interim}/${PGDATABASE}.backup
echo "Making a backup"
pg_dump --format=custom \
  --file=${interim}/${PGDATABASE}.backup ${PGDATABASE}
pg_restore --list ${interim}/${PGDATABASE}.backup
echo "How big is the backup?"
du -sh ${interim}/${PGDATABASE}.backup
