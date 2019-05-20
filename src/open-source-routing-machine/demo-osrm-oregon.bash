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
sudo docker run --privileged -d -p 5000:5000 -v "${PWD}:/data" \
  osrm/osrm-backend osrm-routed --algorithm mld \
  /data/oregon-latest.osrm
echo "Starting map front end server"
sudo docker run --privileged -d -p 9966:9966 osrm/osrm-frontend
