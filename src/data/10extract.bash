#! /bin/bash

# set directories
export RAW=/Raw
export CSVS=/csvs
echo "Checksumming raw archives"
pushd ${RAW}
sha512sum -c *.sha512sum
popd

# extract raw CSVs
echo "Extracting the CSVs"
pushd ${CSVS}
rm *.csv
unar -D "${RAW}/scrapes.rar" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"
unar -D "${RAW}/April 2018.rar" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"
unar -D "${RAW}/May 2018.rar" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"
unzip   "${RAW}/July+2018+to+Dec+2018.zip" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*stopevent*.csv"

echo "tidying up with 'xsv'"
export VEH_STOPH_COLS=EVENT_NO_TRIP,OPD_DATE,VEHICLE_ID,METERS,ACT_ARR_TIME,ACT_DEP_TIME,NOM_ARR_TIME,NOM_DEP_TIME,STOP_ID,STOP_POS,DISTANCE_TO_NEXT,DISTANCE_TO_TRIP,DOORS_OPENING,STOP_TYPE,GPS_LONGITUDE,GPS_LATITUDE,DOOR_OPEN_TIME
export STOP_EVENT_COLS=SERVICE_DATE,VEHICLE_NUMBER,LEAVE_TIME,TRAIN,ROUTE_NUMBER,DIRECTION,SERVICE_KEY,TRIP_NUMBER,STOP_TIME,ARRIVE_TIME,DWELL,LOCATION_ID,DOOR,LIFT,ONS,OFFS,ESTIMATED_LOAD,TRAIN_MILEAGE,X_COORDINATE,Y_COORDINATE
export TRIPSH_COLS=OPD_DATE,VEHICLE_ID,EVENT_NO,METERS,ACT_DEP_TIME,NOM_DEP_TIME,NOM_END_TIME,ACT_END_TIME,LINE_ID,PATTERN_DIRECTION

echo "old veh_stoph"
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-30SEP2017.csv" > raw_veh_stoph_2017_09.csv &
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-31OCT2017.csv" > raw_veh_stoph_2017_10.csv &
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-30NOV2017.csv" > raw_veh_stoph_2017_11.csv &
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-30APR2018.csv" > raw_veh_stoph_2018_04.csv &
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-31MAY2018.csv" > raw_veh_stoph_2018_05.csv &
wait

echo "old stop_event"
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-30SEP2017.csv" > raw_stop_event_2017_09.csv &
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-31OCT2017.csv" > raw_stop_event_2017_10.csv &
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-30NOV2017.csv" > raw_stop_event_2017_11.csv &
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-30APR2018.csv" > raw_stop_event_2018_04.csv &
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-31MAY2018.csv" > raw_stop_event_2018_05.csv &
wait

echo "old tripsh"
xsv select ${TRIPSH_COLS} "init_tripsh 1-30SEP2017.csv" > raw_tripsh_2017_09.csv &
xsv select ${TRIPSH_COLS} "init_tripsh 1-31OCT2017.csv" > raw_tripsh_2017_10.csv &
xsv select ${TRIPSH_COLS} "init_tripsh 1-30NOV2017.csv" > raw_tripsh_2017_11.csv &
xsv select ${TRIPSH_COLS} "init_tripsh 1-30APR2018.csv" > raw_tripsh_2018_04.csv &
xsv select ${TRIPSH_COLS} "init_tripsh 1-31MAY2018.csv" > raw_tripsh_2018_05.csv &
wait

echo "fixing new date stamps"
xsv select ${VEH_STOPH_COLS}  "1 init_veh_stoph July 2018 to Dec 2018.csv" \
  | sed 's/18:00:00:00/2018:00:00:00/' \
  > new_raw_veh_stoph.csv &
xsv select ${STOP_EVENT_COLS} "1 stopevent July 2018 to Dec 2018.csv" \
  | sed 's/18:00:00:00/2018:00:00:00/' \
  > new_raw_stop_event.csv &
xsv select ${TRIPSH_COLS} "1 init_tripsh July 2018 to Dec 2018.csv" \
  | sed 's/18:00:00:00/2018:00:00:00/' \
  > new_raw_tripsh.csv &
wait

echo "extracting new veh_stoph months"
xsv search "JUL2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_07.csv &
xsv search "AUG2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_08.csv &
xsv search "SEP2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_09.csv &
wait
xsv search "OCT2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_10.csv &
xsv search "NOV2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_11.csv &
xsv search "DEC2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_12.csv &
wait

echo "extracting new stop_event months"
xsv search "JUL2018" new_raw_stop_event.csv > raw_stop_event_2018_07.csv &
xsv search "AUG2018" new_raw_stop_event.csv > raw_stop_event_2018_08.csv &
xsv search "SEP2018" new_raw_stop_event.csv > raw_stop_event_2018_09.csv &
wait
xsv search "OCT2018" new_raw_stop_event.csv > raw_stop_event_2018_10.csv &
xsv search "NOV2018" new_raw_stop_event.csv > raw_stop_event_2018_11.csv &
xsv search "DEC2018" new_raw_stop_event.csv > raw_stop_event_2018_12.csv &
wait

echo "extracting new tripsh months"
xsv search "JUL2018" new_raw_tripsh.csv > raw_tripsh_2018_07.csv &
xsv search "AUG2018" new_raw_tripsh.csv > raw_tripsh_2018_08.csv &
xsv search "SEP2018" new_raw_tripsh.csv > raw_tripsh_2018_09.csv &
wait
xsv search "OCT2018" new_raw_tripsh.csv > raw_tripsh_2018_10.csv &
xsv search "NOV2018" new_raw_tripsh.csv > raw_tripsh_2018_11.csv &
xsv search "DEC2018" new_raw_tripsh.csv > raw_tripsh_2018_12.csv &
wait

popd
