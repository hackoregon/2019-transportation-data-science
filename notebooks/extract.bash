#! /bin/bash

# checksum input archives
pushd "/home/znmeb/Raw/transportation-2018/transit-operations-analytics-data"
sha512sum -c scrapes.rar.sha512sum
sha512sum -c April\ 2018.rar.sha512sum
sha512sum -c May\ 2018.rar.sha512sum

# extract raw CSVs
rm *.csv *.xlsx *.txt
unrar x scrapes.rar "*.csv"
unrar x April\ 2018.rar "*.csv"
unrar x May\ 2018.rar

# concatenate
/usr/bin/time grep -v '_DATE,' \
  "init_cyclic_v1h 1-30SEP2017.csv" \
  "init_cyclic_v1h 1-31OCT2017.csv" \
  "init_cyclic_v1h 1-30NOV2017.csv" \
  "init_cyclic_v1h 1-30APR2018.csv" \
  "init_cyclic_v1h 1-31MAY2018.csv" \
  > init_cyclic_v1h.csv
/usr/bin/time grep -v '_DATE,' \
  "init_tripsh 1-30SEP2017.csv" \
  "init_tripsh 1-31OCT2017.csv" \
  "init_tripsh 1-30NOV2017.csv" \
  "init_tripsh 1-30APR2018.csv" \
  "init_tripsh 1-31MAY2018.csv" \
  > init_tripsh.csv
/usr/bin/time grep -v '_DATE,' \
  "init_veh_stoph 1-30SEP2017.csv" \
  "init_veh_stoph 1-31OCT2017.csv" \
  "init_veh_stoph 1-30NOV2017.csv" \
  "init_veh_stoph 1-30APR2018.csv" \
  "init_veh_stoph 1-31MAY2018.csv" \
  > init_veh_stoph.csv
/usr/bin/time grep -v '_DATE,' \
  "trimet_stop_event 1-30SEP2017.csv" \
  "trimet_stop_event 1-31OCT2017.csv" \
  "trimet_stop_event 1-30NOV2017.csv" \
  "trimet_stop_event 1-30APR2018.csv" \
  "trimet_stop_event 1-31MAY2018.csv" \
  > trimet_stop_event.csv

popd
