#! /bin/bash

/usr/bin/time ./10extract.bash
/usr/bin/time ./15create_database.bash
/usr/bin/time ./20traffic_signals.bash
/usr/bin/time ./21load_reference.bash
/usr/bin/time ./22passenger_census.bash
/usr/bin/time ./25NCDB_Sample_Transportation_Commute.bash
/usr/bin/time ./26busstop_catchment_zone_with_census_attribs.bash
/usr/bin/time ./27load_raw_data.bash
/usr/bin/time ./30rail_passenger_stops.bash
/usr/bin/time ./32bus_passenger_stops.bash
/usr/bin/time ./34disturbance_stops.bash
/usr/bin/time ./36summary_statistics.bash
/usr/bin/time ./38index_passenger_stops.bash
/usr/bin/time ./70create_database_backup.bash
