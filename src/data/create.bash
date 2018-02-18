#! /bin/bash

# define arrays
filedates=("1-30SEP2017" "1-31OCT2017" "1-30NOV2017")
tabledates=("end20170930" "end20171031" "end20171130")
tablenames=("init_cyclic_v1h" "init_tripsh" "init_veh_stoph" "trimet_stop_event")

# connect to database

# load the tables
for datex in 0 1 2
do
  for tablex in 0 1 2 3
  do
    filename="${tablenames[$tablex]} ${filedates[$datex]}.csv"
    tablename="${tabledates[$datex]}_${tablenames[$tablex]}"
    echo "$filename => $tablename"
  done
done
