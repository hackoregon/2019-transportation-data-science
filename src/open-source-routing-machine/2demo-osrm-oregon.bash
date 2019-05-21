#! /bin/bash

echo "Civic Foundation HQ to Oregon State Capitol"
"http://localhost:9966/?z=9&center=45.259422%2C-123.071594&loc=45.523732%2C-122.662378&loc=44.938755%2C-123.030138&hl=en&alt=0"
echo "Starting routing server"
sudo docker rm --force osrm-backend
sudo docker run --privileged --name osrm-backend --detach --publish 5000:5000 --volume "${PWD}:/data" \
  osrm/osrm-backend osrm-routed --algorithm mld /data/oregon-latest.osrm
echo "Starting map front end server"
echo "Browse to IP address given when server is up"
sudo docker rm --force osrm-frontend
sudo docker run --name osrm-frontend --tty --publish 9966:9966 \
  osrm/osrm-frontend
