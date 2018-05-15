#! /bin/bash

# raw data
if [ ! -e ../../data/raw/scrapes.rar ]
then
  echo "Input file ../../data/raw/scrapes.rar does not exist - exiting!"
  exit
fi
if [ ! -e ../../data/raw/passenger_census.csv ]
then
  echo "Input file ../../data/raw/passenger_census.csv does not exist - exiting!"
  exit
fi

echo "Copying raw data to the container"
docker cp ../../data/raw containers_postgis_1:/home/dbsuper/Raw

echo "Copying the scripts to the container"
docker cp trimet_database_scripts containers_postgis_1:/home/dbsuper

exit
echo "Creating the database in the container"
echo ""
echo ""
docker exec -it -u dbsuper -w /home/dbsuper/trimet_database_scripts containers_postgis_1 ./create_database.bash

echo "Retriving the backups"
docker cp containers_postgis_1:home/dbsuper/Raw/transportation-systems-trimet.sql.gz ../../data/interim/
ls -ltr ../../containers/Raw
