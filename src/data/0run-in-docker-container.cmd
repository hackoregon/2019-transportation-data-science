docker build --file=Dockerfile.postgis --tag=postgis-image:latest .
docker images
docker run --detach --name=postgis-container ^
  --publish 5439:5432 ^
  postgis-image ^
  -c 'shared_buffers=1GB' ^
  -c 'effective_cache_size=2GB' ^
  -c 'work_mem=128MB' ^
  -c 'maintenance_work_mem=128MB' ^
  -c 'checkpoint_timeout=20min' ^
  -c 'max_wal_size=4GB'
sleep 30
docker ps
docker logs postgis-container
docker cp . postgis-container:/home/dbsuper/
docker cp ${RAW} postgis-container:/home/dbsuper/Raw/
docker exec --user=dbsuper --workdir=/home/dbsuper postgis-container /home/dbsuper/0runall.bash
docker cp postgis-container:/csvs/transit_operations_analytics_data.sql.gz .
docker cp postgis-container:/csvs/transit_operations_analytics_data.sql.gz.sha512sum .
sha512sum -c transit_operations_analytics_data.sql.gz.sha512sum
docker cp postgis-container:/csvs/transit_operations_analytics_data.html .
