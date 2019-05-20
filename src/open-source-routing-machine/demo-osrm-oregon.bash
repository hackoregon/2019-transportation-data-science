#! /bin/bash

echo "Downloading Oregon OpenStreetMap data"
wget -nc https://download.geofabrik.de/north-america/us/oregon-latest.osm.pbf
echo "Processing bicycle routing network"
sudo docker run --privileged --rm -t -v "${PWD}:/data" \
  osrm/osrm-backend osrm-extract -p /opt/bicycle.lua \
  /data/oregon-latest.osm.pbf
sudo docker run --privileged --rm -t -v "${PWD}:/data" \
  osrm/osrm-backend osrm-partition \
  /data/oregon-latest.osrm
sudo docker run --privileged --rm -t -v "${PWD}:/data" \
  osrm/osrm-backend osrm-customize \
  /data/oregon-latest.osrm
echo "Starting routing server"
sudo docker rm --force osrm-backend
sudo docker run --privileged --name osrm-backend -d -p 5000:5000 -v "${PWD}:/data" \
  osrm/osrm-backend osrm-routed --algorithm mld \
  /data/oregon-latest.osrm
echo "Starting map front end server"
sudo docker rm --force osrm-frontend
sudo docker run --name osrm-frontend -d -p 9966:9966 osrm/osrm-frontend
echo "Bicycle route from Civic Foundation World Headquarters to Oregon State Capitol"
echo "Sleeping 30 seconds for front end to stabilize"
sleep 30
xdg-open "http://localhost:9966/?z=9&center=45.259422%2C-123.071594&loc=45.523732%2C-122.662378&loc=44.938755%2C-123.030138&hl=en&alt=0"
