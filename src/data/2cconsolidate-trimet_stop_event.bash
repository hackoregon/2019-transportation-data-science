#! /bin/bash

# define parameters
export interim="../../data/interim"
export raw="../raw"

echo "Consolidating the CSVs"
pushd ${interim}
grep -h -v VEHICLE_NUMBER \
  "${raw}/trimet_stop_event 1-30SEP2017.csv" \
  "${raw}/trimet_stop_event 1-31OCT2017.csv" \
  "${raw}/trimet_stop_event 1-30NOV2017.csv" \
  > trimet_stop_event.csv
popd
