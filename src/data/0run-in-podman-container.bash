#! /bin/bash

echo "Building the image"
podman build --tag postgis:latest .
podman images
echo "Force-removing all existing containers"
podman rm -f `podman ps -aq`
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
podman cp postgisc:/csvs/transit_operations_analytics_data.sql.gz .
podman cp postgisc:/csvs/transit_operations_analytics_data.sql.gz.sha512sum .
sha512sum -c transit_operations_analytics_data.sql.gz.sha512sum
echo "Retrieving database schema"
podman exec --user=postgres --workdir=/src/ postgisc postgresql_autodoc -d transit_operations_analytics_data -t html
podman cp postgisc:/src/transit_operations_analytics_data.html .
