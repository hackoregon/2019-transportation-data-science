#! /bin/bash

# define parameters
export interim="../../data/interim"

# unpack the raw data
pushd ${interim}
echo "Unpacking the archive"
/usr/bin/time unrar e -inul ../raw/scrapes.rar

echo "Consolidating the CSVs"
cat \
  "init_cyclic_v1h 1-30SEP2017.csv" \
  "init_cyclic_v1h 1-31OCT2017.csv" \
  "init_cyclic_v1h 1-30NOV2017.csv" \
  | grep -v VEHICLE_ID > init_cyclic_v1h.csv &
cat \
  "init_veh_stoph 1-30SEP2017.csv" \
  "init_veh_stoph 1-31OCT2017.csv" \
  "init_veh_stoph 1-30NOV2017.csv" \
  | grep -v VEHICLE_ID > init_veh_stoph.csv &
cat \
  "trimet_stop_event 1-30SEP2017.csv" \
  "trimet_stop_event 1-31OCT2017.csv" \
  "trimet_stop_event 1-30NOV2017.csv" \
  | grep -v VEHICLE_NUMBER > trimet_stop_event.csv &
cat \
  "init_tripsh 1-30SEP2017.csv" \
  "init_tripsh 1-31OCT2017.csv" \
  "init_tripsh 1-30NOV2017.csv" \
  | grep -v VEHICLE_ID > init_tripsh.csv &

wait

popd
