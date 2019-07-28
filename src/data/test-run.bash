#! /bin/bash

docker-compose down
sudo rm -fr /home/container-postgres
docker-compose up -d --build
sleep 10
docker logs data_postgis_1
docker exec --interactive --tty --user=transportation2019 --workdir=/home/transportation2019/scripts \
  data_postgis_1 /bin/bash 00runall.bash
