#! /bin/bash

pushd "/home/znmeb/Raw/transportation-2018/transit-operations-analytics-data"
DEST=/home/csvs

# concatenate
echo "stacking init_cyclic_v1h"
/usr/bin/time tail --silent --lines=+2 \
  "init_cyclic_v1h 1-30SEP2017.csv" \
  "init_cyclic_v1h 1-31OCT2017.csv" \
  "init_cyclic_v1h 1-30NOV2017.csv" \
  "init_cyclic_v1h 1-30APR2018.csv" \
  "init_cyclic_v1h 1-31MAY2018.csv" \
  > ${DEST}/init_cyclic_v1h.csv
echo "stacking init_tripsh"
/usr/bin/time tail --silent --lines=+2 \
  "init_tripsh 1-30SEP2017.csv" \
  "init_tripsh 1-31OCT2017.csv" \
  "init_tripsh 1-30NOV2017.csv" \
  "init_tripsh 1-30APR2018.csv" \
  "init_tripsh 1-31MAY2018.csv" \
  > ${DEST}/init_tripsh.csv
echo "stacking init_veh_stoph"
/usr/bin/time tail --silent --lines=+2 \
  "init_veh_stoph 1-30SEP2017.csv" \
  "init_veh_stoph 1-31OCT2017.csv" \
  "init_veh_stoph 1-30NOV2017.csv" \
  "init_veh_stoph 1-30APR2018.csv" \
  "init_veh_stoph 1-31MAY2018.csv" \
  > ${DEST}/init_veh_stoph.csv
echo "stacking trimet_stop_event"
/usr/bin/time tail --silent --lines=+2 \
  "trimet_stop_event 1-30SEP2017.csv" \
  "trimet_stop_event 1-31OCT2017.csv" \
  "trimet_stop_event 1-30NOV2017.csv" \
  "trimet_stop_event 1-30APR2018.csv" \
  "trimet_stop_event 1-31MAY2018.csv" \
  > ${DEST}/trimet_stop_event.csv

popd
