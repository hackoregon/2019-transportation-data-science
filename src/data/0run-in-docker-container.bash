#! /bin/bash

# Environment variables
export RAW=~/Raw/transportation-2018/transit-operations-analytics-data/
export CONTAINER_PGDATA=/home/container-postgres
export CONTAINER_CSVS=/home/container-csvs

# get a fresh host directory for container PGDATA
echo "Force-removing all existing containers"
sudo docker rm -f ` sudo docker ps -aq`
echo "Force-removing ${CONTAINER_PGDATA}"
echo "Docker will create a fresh one"
sudo rm -fr ${CONTAINER_PGDATA}
echo "Creating TMPDIR ${CONTAINER_CSVS}"
sudo mkdir -p ${CONTAINER_CSVS}
sudo chmod 1777 ${CONTAINER_CSVS}

echo "Building the PostGIS image"
sudo docker build --file=Dockerfile.postgis --tag=postgis-image:latest .
sudo docker images
echo "Running the container"
sudo docker run --detach --name=postgis-container \
  --publish 5439:5432 \
  --volume ${RAW}:/home/dbsuper/Raw \
  --volume ${CONTAINER_PGDATA}:/var/lib/postgresql/data \
  --volume ${CONTAINER_CSVS}:/csvs \
  postgis-image \
  -c 'shared_buffers=8GB' \
  -c 'effective_cache_size=24GB' \
  -c 'work_mem=1GB' \
  -c 'maintenance_work_mem=1GB' \
  -c 'checkpoint_timeout=20min' \
  -c 'max_wal_size=4GB'
sleep 30
sudo docker ps
sudo docker logs postgis-container
echo "Copying the scripts"
sudo docker cp . postgis-container:/home/dbsuper/
echo "Loading the database"
sudo docker exec --user=dbsuper --workdir=/home/dbsuper postgis-container /home/dbsuper/0runall.bash
echo "Retrieving the backup"
sudo docker cp postgis-container:/csvs/transit_operations_analytics_data.backup .
sudo docker cp postgis-container:/csvs/transit_operations_analytics_data.backup.sha512sum .
sha512sum -c transit_operations_analytics_data.backup.sha512sum
echo "Retrieving database schema"
sudo docker cp postgis-container:/csvs/transit_operations_analytics_data.html .
