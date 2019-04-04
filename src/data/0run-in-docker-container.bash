#! /bin/bash

echo "Building the image"
docker build --tag postgis:latest .
docker images
echo "Force-removing all existing containers"
docker rm -f `docker ps -aq`
echo "Running the container"
docker run --detach --rm --name=postgisc --volume /csvs:/csvs postgis
docker ps
echo "Copying the scripts"
docker cp . postgisc:/src
docker exec --user=root postgisc chown -R postgres:postgres /src
echo "Chowning the input CSVs"
docker exec --user=root postgisc chown -R postgres:postgres /csvs
echo "Loading the database"
sleep 30
docker exec --user=postgres --workdir=/src postgisc /src/2load.bash
docker exec --user=postgres --workdir=/src postgisc /src/9create-database-backup.bash
echo "Retrieving the backup"
docker cp postgisc:/csvs/transit_operations_analytics_data.sql.gz .
docker cp postgisc:/csvs/transit_operations_analytics_data.sql.gz.sha512sum .
sha512sum -c transit_operations_analytics_data.sql.gz.sha512sum
echo "Retrieving database schema"
docker exec --user=postgres --workdir=/src/ postgisc postgresql_autodoc -d transit_operations_analytics_data -t html
docker cp postgisc:/src/transit_operations_analytics_data.html .
