#! /bin/bash

# checksum input archives
export RAW="/home/znmeb/Raw/transportation-2018/transit-operations-analytics-data"
export CSVS=/csvs
echo "Checksumming raw archives"
pushd ${RAW}
sha512sum -c scrapes.rar.sha512sum
popd

# extract raw CSVs
echo "Extracting the CSVs"
sudo chown -R ${USER}:${USER} ${CSVS}
pushd ${CSVS}
rm *.csv
unrar x ${RAW}/scrapes.rar \
  "init_tripsh*.csv" "init_veh_stoph*.csv" "trimet_stop_event*.csv" "init_cyclic_v1h*.csv"
popd
