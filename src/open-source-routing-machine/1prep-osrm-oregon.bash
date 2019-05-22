#! /bin/bash

echo "Downloading Oregon OpenStreetMap data"
wget -nc https://download.geofabrik.de/north-america/us/oregon-latest.osm.pbf
echo "Processing bicycle routing network"
sudo docker run --privileged --rm --tty --volume "${PWD}:/data" \
  osrm/osrm-backend osrm-extract -p /opt/bicycle.lua /data/oregon-latest.osm.pbf
sudo docker run --privileged --rm --tty --volume "${PWD}:/data" \
  osrm/osrm-backend osrm-partition /data/oregon-latest.osrm
sudo docker run --privileged --rm --tty --volume "${PWD}:/data" \
  osrm/osrm-backend osrm-customize /data/oregon-latest.osrm
echo "Pulling the front end image"
sudo docker pull osrm/osrm-frontend
