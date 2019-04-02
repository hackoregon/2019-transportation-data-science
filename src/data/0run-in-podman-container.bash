#! /bin/bash

echo "Building the image"
podman build --tag postgis:latest .
podman images
echo "Force-removing existing containers"
podman rm -f `docker ps -aq`
echo "Running the container"
podman run --detach --rm --name=postgisc --volume /csvs:/csvs postgis
podman ps
echo "Copying the scripts"
podman cp . postgisc:/src
podman exec --user=root postgisc chown -R postgres:postgres /src
echo "Chowning the input CSVs"
podman exec --user=root postgisc chown -R postgres:postgres /csvs
echo "Loading the database"
sleep 30
podman exec --user=postgres --workdir=/src postgisc /src/2load.bash
podman exec --user=postgres --workdir=/src postgisc /src/9create-database-backup.bash
echo "Retrieving the backup"
podman cp postgisc:/csvs/transit_operations_analytics_data.backup .
podman cp postgisc:/csvs/transit_operations_analytics_data.backup.sha512sum .
sha512sum -c transit_operations_analytics_data.backup.sha512sum
