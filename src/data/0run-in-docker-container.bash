#! /bin/bash

echo "Building the image"
docker build --tag postgis-image:latest .
docker images
echo "Force-removing all existing containers"
docker rm -f `docker ps -aq`
echo "Running the container"
docker run --detach --name=postgis-container --volume /csvs:/csvs postgis-image \
  -c 'shared_buffers=1024MB' \
  -c 'work_mem=256MB' \
  -c 'maintenance_work_mem=256MB' \
  -c 'checkpoint_timeout=20min' \
  -c 'max_wal_size=4GB'
docker ps
echo "Copying the scripts"
docker cp . postgis-container:/src
docker exec --user=root postgis-container chown -R postgres:postgres /src
echo "Chowning the input CSVs"
docker exec --user=root postgis-container chown -R postgres:postgres /csvs
echo "Loading the database"
sleep 30
docker exec --user=postgres --workdir=/src postgis-container /src/2load.bash
docker exec --user=postgres --workdir=/src postgis-container /src/3build_model.bash
docker exec --user=postgres --workdir=/src postgis-container /src/4cleanup.bash
docker exec --user=postgres --workdir=/src postgis-container /src/9create-database-backup.bash
docker exec --user=root --workdir=/src postgis-container du -sh /var/lib/postgresql/data
echo "Retrieving the backup"
docker cp postgis-container:/csvs/transit_operations_analytics_data.sql.gz .
docker cp postgis-container:/csvs/transit_operations_analytics_data.sql.gz.sha512sum .
sha512sum -c transit_operations_analytics_data.sql.gz.sha512sum
echo "Retrieving database schema"
docker exec --user=postgres --workdir=/src/ postgis-container \
  postgresql_autodoc -d transit_operations_analytics_data -t html
docker cp postgis-container:/src/transit_operations_analytics_data.html .
