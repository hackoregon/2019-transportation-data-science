#! /bin/bash

source .pgauth
postgresql_autodoc -d $PGDATABASE -h $PGHOST -u $PGUSER --password=$PGPASSWORD -t html \
--table=bus_all_stops,bus_passenger_stops,bus_trips,disturbance_stops,rail_passenger_stops,tl_2018_41_bg,\
tl_2018_41_tabblock10,tl_2018_41_tract,tm_boundary,tm_parkride,tm_rail_lines,tm_rail_stops,tm_route_stops,\
tm_routes,tm_stops,tm_tran_cen,traffic_signals
