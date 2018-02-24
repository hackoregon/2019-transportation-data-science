#! /bin/bash

# define parameters
export interim="../../data/interim"
export raw="../raw"

echo "Consolidating the CSVs"
pushd ${interim}
cat \
  "${raw}/init_cyclic_v1h 1-30SEP2017.csv" \
  "${raw}/init_cyclic_v1h 1-31OCT2017.csv" \
  "${raw}/init_cyclic_v1h 1-30NOV2017.csv" \
  | grep -v VEHICLE_ID > init_cyclic_v1h.csv &
cat \
  "${raw}/init_veh_stoph 1-30SEP2017.csv" \
  "${raw}/init_veh_stoph 1-31OCT2017.csv" \
  "${raw}/init_veh_stoph 1-30NOV2017.csv" \
  | grep -v VEHICLE_ID > init_veh_stoph.csv &
cat \
  "${raw}/trimet_stop_event 1-30SEP2017.csv" \
  "${raw}/trimet_stop_event 1-31OCT2017.csv" \
  "${raw}/trimet_stop_event 1-30NOV2017.csv" \
  | grep -v VEHICLE_NUMBER > trimet_stop_event.csv &
cat \
  "${raw}/init_tripsh 1-30SEP2017.csv" \
  "${raw}/init_tripsh 1-31OCT2017.csv" \
  "${raw}/init_tripsh 1-30NOV2017.csv" \
  | grep -v VEHICLE_ID > init_tripsh.csv &

wait

popd
