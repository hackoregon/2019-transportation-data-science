#! /bin/bash

echo "Starting routing server"
sudo docker rm --force osrm-backend
sudo docker run --privileged --detach \
  --volume "${PWD}:/data" \
  --name osrm-backend --network bridge --publish 5000:5000 \
  osrm/osrm-backend osrm-routed --algorithm mld /data/oregon-latest.osrm
echo "Starting map front end server"
echo "Browse to http://localhost:9966 after server starts"
sleep 15
sudo docker rm --force osrm-frontend
sudo docker run --tty \
  --name osrm-frontend --network bridge --publish 9966:9966 \
  osrm/osrm-frontend
