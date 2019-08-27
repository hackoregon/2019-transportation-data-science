#! /bin/bash

/usr/bin/time ./10extract.bash
/usr/bin/time ./15create_database.bash
/usr/bin/time ./20traffic_signals.bash
/usr/bin/time ./22passenger_census.bash
/usr/bin/time ./23NCDB_Sample_Transportation_Commute.bash
/usr/bin/time ./24load_reference.bash
/usr/bin/time ./27load_raw_data.bash
/usr/bin/time ./30create_partitioned_tables.bash
/usr/bin/time ./70create_database_backup.bash
