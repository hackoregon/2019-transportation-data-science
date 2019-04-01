#! /bin/bash

echo "Building the image"
docker build --tag postgis:latest .
docker images
echo "Force-removing existing containers"
docker rm -f `docker ps -aq`
echo "Running the container"
docker run --detach --rm --name=postgisc postgis
docker ps
echo "Copying the scripts"
docker cp . postgisc:/src
docker exec postgisc chown -R postgres:postgres /src
echo "Copying the input CSVs"
docker cp /csvs postgisc:/csvs
docker exec postgisc chown -R postgres:postgres /csvs
echo "Loading the database"
docker exec --user=postgres --workdir=/src postgisc /src/2load.bash 2>&1 | tee /csvs/load.log
echo "Backing up the database"
docker exec --user=postgres --workdir=/src postgisc /src/9create-database-backup.bash
echo "Retrieving the backup"
docker cp postgisc:/csvs/transit_operations_analytics_data.sql.gz .
docker cp postgisc:/csvs/transit_operations_analytics_data.sql.gz.sha512sum .
