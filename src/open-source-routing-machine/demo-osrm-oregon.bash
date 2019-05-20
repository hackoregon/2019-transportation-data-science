#! /bin/bash

wget -nc https://download.geofabrik.de/north-america/us/oregon-latest.osm.pbf
sudo docker run --privileged -t -v "${PWD}:/data" \
  osrm/osrm-backend osrm-extract -p /opt/car.lua \
  /data/oregon-latest.osm.pbf
sudo docker run --privileged -t -v "${PWD}:/data" \
  osrm/osrm-backend osrm-partition \
  /data/oregon-latest.osrm
sudo docker run --privileged -t -v "${PWD}:/data" \
  osrm/osrm-backend osrm-customize \
  /data/oregon-latest.osrm
sudo docker run --privileged -d -p 5000:5000 -v "${PWD}:/data" \
  osrm/osrm-backend osrm-routed --algorithm mld \
  /data/oregon-latest.osrm
sudo docker run --privileged -d -p 9966:9966 osrm/osrm-frontend
xdg-open 'http://127.0.0.1:9966'
