#! /bin/bash

export WHERE=https://developer.trimet.org/gis/data
for i in \
  $WHERE/tm_boundary.zip \
  $WHERE/tm_parkride.zip \
  $WHERE/tm_rail_lines.zip \
  $WHERE/tm_rail_stops.zip \
  $WHERE/tm_route_stops.zip \
  $WHERE/tm_routes.zip \
  $WHERE/tm_stops.zip \
  $WHERE/tm_tran_cen.zip
do
  echo $i
  wget --no-clobber --quiet $i
done

export WHERE=https://www2.census.gov/geo/tiger/TIGER2018
for i in \
  $WHERE/BG/tl_2018_41_bg.zip \
  $WHERE/TABBLOCK/tl_2018_41_tabblock10.zip \
  $WHERE/TRACT/tl_2018_41_tract.zip
do
  echo $i
  wget --no-clobber --quiet $i
done
