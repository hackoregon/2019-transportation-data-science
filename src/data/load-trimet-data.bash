#! /bin/bash

export WHERE=https://developer.trimet.org/gis/data
pushd ../../data/external
for table in tm_boundary tm_parkride tm_rail_lines tm_rail_stops tm_routes tm_stops tm_route_stops tm_tran_cen
do
  wget -nc -q $WHERE/$table.zip
  rm -fr $table; mkdir $table; cd $table
  unzip ../$table.zip
  cd ..
done
popd
