#! /bin/bash

# define parameters
export interim="../../data/interim"
export raw="../raw"

echo "Consolidating the CSVs"
pushd ${interim}
grep -h -v VEHICLE_ID \
  "${raw}/init_cyclic_v1h 1-30SEP2017.csv" \
  "${raw}/init_cyclic_v1h 1-31OCT2017.csv" \
  "${raw}/init_cyclic_v1h 1-30NOV2017.csv" \
  > init_cyclic_v1h.csv
popd
