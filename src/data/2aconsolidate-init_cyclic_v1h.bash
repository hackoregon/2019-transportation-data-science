#! /bin/bash

# define parameters
export interim="../../data/interim"
export raw="../raw"

echo "Consolidating the CSVs"
pushd ${interim}
head -n 1 "${raw}/init_cyclic_v1h 1-30SEP2017.csv" | tr '[:upper:]' '[:lower:]' > init_cyclic_v1h.csv
grep -h -v VEHICLE_ID \
  "${raw}/init_cyclic_v1h 1-30SEP2017.csv" \
  "${raw}/init_cyclic_v1h 1-31OCT2017.csv" \
  "${raw}/init_cyclic_v1h 1-30NOV2017.csv" \
  >> init_cyclic_v1h.csv
popd
