#! /bin/bash

# define parameters
export raw="../../data/raw"
export interim="../../data/interim"

# unpack the raw data
pushd ${interim}
echo "Unpacking the archive"
/usr/bin/time unrar e -inul ../raw/scrapes.rar
popd

# stack the CSVs
cat \
  "${interim}/init_cyclic_v1h 1-30SEP2017.csv" \
  "${interim}/init_cyclic_v1h 1-31OCT2017.csv" \
  "${interim}/init_cyclic_v1h 1-30NOV2017.csv" \
  | grep -v VEHICLE_ID > ${interim}/init_cyclic_v1h.csv &
cat \
  "${interim}/init_veh_stoph 1-30SEP2017.csv" \
  "${interim}/init_veh_stoph 1-31OCT2017.csv" \
  "${interim}/init_veh_stoph 1-30NOV2017.csv" \
  | grep -v VEHICLE_ID > ${interim}/init_veh_stoph.csv &
cat \
  "${interim}/trimet_stop_event 1-30SEP2017.csv" \
  "${interim}/trimet_stop_event 1-31OCT2017.csv" \
  "${interim}/trimet_stop_event 1-30NOV2017.csv" \
  | grep -v VEHICLE_NUMBER > ${interim}/trimet_stop_event.csv &
cat \
  "${interim}/init_tripsh 1-30SEP2017.csv" \
  "${interim}/init_tripsh 1-31OCT2017.csv" \
  "${interim}/init_tripsh 1-30NOV2017.csv" \
  | grep -v VEHICLE_ID > ${interim}/init_tripsh.csv &

wait
