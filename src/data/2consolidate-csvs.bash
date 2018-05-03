#! /bin/bash

# define parameters
export interim="../../data/interim"
export raw="../raw"

echo "Consolidating the CSVs"
pushd ${interim}
grep -v VEHICLE_ID \
  "${raw}/init_cyclic_v1h 1-30SEP2017.csv" \
  "${raw}/init_cyclic_v1h 1-31OCT2017.csv" \
  "${raw}/init_cyclic_v1h 1-30NOV2017.csv" \
  > init_cyclic_v1h.csv &
grep -v VEHICLE_ID \
  "${raw}/init_veh_stoph 1-30SEP2017.csv" \
  "${raw}/init_veh_stoph 1-31OCT2017.csv" \
  "${raw}/init_veh_stoph 1-30NOV2017.csv" \
  > init_veh_stoph.csv &
grep -v VEHICLE_NUMBER \
  "${raw}/trimet_stop_event 1-30SEP2017.csv" \
  "${raw}/trimet_stop_event 1-31OCT2017.csv" \
  "${raw}/trimet_stop_event 1-30NOV2017.csv" \
  > trimet_stop_event.csv &
grep -v VEHICLE_ID \
  "${raw}/init_tripsh 1-30SEP2017.csv" \
  "${raw}/init_tripsh 1-31OCT2017.csv" \
  "${raw}/init_tripsh 1-30NOV2017.csv" \
  > init_tripsh.csv &

wait

popd
