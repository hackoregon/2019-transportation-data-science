#! /bin/bash

## Redesigned to work in containers. We run this on the PostgreSQL image https://hub.docker.com/_/postgres but it
## should run on any Debian "stretch" system that has "unzip", "unar" and "xsv" installed.

## set directories
export RAW=/Raw
export CSVS=/Work

## The master source for ${RAW} is S3. We computed checksums for the archives we received and stored them in ${RAW}
echo "Checksumming raw archives"
pushd ${RAW}
sha512sum -c *.sha512sum
popd

## The early archives we received were in "rar" format. Later ones were in "zip" format. We use "unar" for the "rar"
## files and "unzip" for the "zip" files. Both are available in most Linux distros, including Debian "stretch".
echo "Extracting the CSVs"
pushd ${CSVS}
rm *.csv
unar -D "${RAW}/scrapes.rar" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"
unar -D "${RAW}/April 2018.rar" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"
unar -D "${RAW}/May 2018.rar" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"
unzip   "${RAW}/July+2018+to+Dec+2018.zip" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*stopevent*.csv"

## We use "xsv" (https://github.com/BurntSushi/xsv) to standardize the CSV files for input to data science and
## database loading processes. It's available in some Linux distros, but we use the binary release since it's not in
## Debian "stretch".
echo "defining the columns to retain"
export VEH_STOPH_COLS=EVENT_NO_TRIP,OPD_DATE,VEHICLE_ID,METERS,ACT_ARR_TIME,ACT_DEP_TIME,NOM_ARR_TIME,NOM_DEP_TIME,STOP_ID,STOP_POS,DISTANCE_TO_NEXT,DISTANCE_TO_TRIP,DOORS_OPENING,STOP_TYPE,GPS_LONGITUDE,GPS_LATITUDE,DOOR_OPEN_TIME
export STOP_EVENT_COLS=SERVICE_DATE,VEHICLE_NUMBER,LEAVE_TIME,TRAIN,ROUTE_NUMBER,DIRECTION,SERVICE_KEY,TRIP_NUMBER,STOP_TIME,ARRIVE_TIME,DWELL,LOCATION_ID,DOOR,LIFT,ONS,OFFS,ESTIMATED_LOAD,TRAIN_MILEAGE,X_COORDINATE,Y_COORDINATE
export TRIPSH_COLS=OPD_DATE,VEHICLE_ID,EVENT_NO,METERS,ACT_DEP_TIME,NOM_DEP_TIME,NOM_END_TIME,ACT_END_TIME,LINE_ID,PATTERN_DIRECTION

## Each month contains four files. There is a large file ("cyclic") which contains all timestamped vehicle positions.
## It appears to contain only buses, and we do not use it.
##
## There is a small "trips history". This appears to be buses only and lists the start and end times of all the trips.
## And there are two stop event tables. The first, "stop history", contains all the stops a vehicle made, whether for
## passengers or not. This also appears to be buses only, and joins with the "trips history":
## - "trips_history.EVENT_NUMBER" = "stop_history.EVENT_NUMBER_TRIP".
##
## The final table is "(trimet) stop event". It contains both bus and MAX data but does not appear to have streetcar or
## aerial tram stops. The stops are only scheduled / unscheduled passenger stops at defined stop locations. The rows
## contain a "trip number" but it is *not* the same as "EVENT_NO_TRIP" in the "stop_history" table. We need to
## compute the trips from the stop events in this table using logic in either R / Python or SQL.
##
## Finally, the "old format" / "rar" archives contain four files for each month, and we have five months: September
## 2017, October 2017, November 2017, April 2018 and May 2018. The "new format" archives contain the six months from
## July 2018 through December 2018, one archive per data table type. And the columns differ between the two formats.
## And the December 2018 tables have fewer trips that we expected - we haven't asked TriMet about that yet.

## Processing the old format files is easy - we only need to select the columns we're using
echo "old format vehicle stop history"
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-30SEP2017.csv" > raw_veh_stoph_2017_09.csv
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-31OCT2017.csv" > raw_veh_stoph_2017_10.csv
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-30NOV2017.csv" > raw_veh_stoph_2017_11.csv
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-30APR2018.csv" > raw_veh_stoph_2018_04.csv
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-31MAY2018.csv" > raw_veh_stoph_2018_05.csv
rm "init_veh_stoph 1-30SEP2017.csv"
rm "init_veh_stoph 1-31OCT2017.csv"
rm "init_veh_stoph 1-30NOV2017.csv"
rm "init_veh_stoph 1-30APR2018.csv"
rm "init_veh_stoph 1-31MAY2018.csv"

echo "old format stop events"
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-30SEP2017.csv" > raw_stop_event_2017_09.csv
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-31OCT2017.csv" > raw_stop_event_2017_10.csv
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-30NOV2017.csv" > raw_stop_event_2017_11.csv
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-30APR2018.csv" > raw_stop_event_2018_04.csv
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-31MAY2018.csv" > raw_stop_event_2018_05.csv
rm "trimet_stop_event 1-30SEP2017.csv"
rm "trimet_stop_event 1-31OCT2017.csv"
rm "trimet_stop_event 1-30NOV2017.csv"
rm "trimet_stop_event 1-30APR2018.csv"
rm "trimet_stop_event 1-31MAY2018.csv"

echo "old format trips history"
xsv select ${TRIPSH_COLS} "init_tripsh 1-30SEP2017.csv" > raw_tripsh_2017_09.csv
xsv select ${TRIPSH_COLS} "init_tripsh 1-31OCT2017.csv" > raw_tripsh_2017_10.csv
xsv select ${TRIPSH_COLS} "init_tripsh 1-30NOV2017.csv" > raw_tripsh_2017_11.csv
xsv select ${TRIPSH_COLS} "init_tripsh 1-30APR2018.csv" > raw_tripsh_2018_04.csv
xsv select ${TRIPSH_COLS} "init_tripsh 1-31MAY2018.csv" > raw_tripsh_2018_05.csv
rm "init_tripsh 1-30SEP2017.csv"
rm "init_tripsh 1-31OCT2017.csv"
rm "init_tripsh 1-30NOV2017.csv"
rm "init_tripsh 1-30APR2018.csv"
rm "init_tripsh 1-31MAY2018.csv"

## The old format files had date stamps of the form "ddMMMyyyy" and the new ones are of the form "ddMMMyy". So we 
## standardize on the old format using "sed".
echo "fixing new date stamps"
xsv select ${VEH_STOPH_COLS}  "1 init_veh_stoph July 2018 to Dec 2018.csv" \
  | sed 's/18:00:00:00/2018:00:00:00/' \
  > new_raw_veh_stoph.csv
xsv select ${STOP_EVENT_COLS} "1 stopevent July 2018 to Dec 2018.csv" \
  | sed 's/18:00:00:00/2018:00:00:00/' \
  > new_raw_stop_event.csv
xsv select ${TRIPSH_COLS} "1 init_tripsh July 2018 to Dec 2018.csv" \
  | sed 's/18:00:00:00/2018:00:00:00/' \
  > new_raw_tripsh.csv
rm "1 init_veh_stoph July 2018 to Dec 2018.csv"
rm "1 stopevent July 2018 to Dec 2018.csv"
rm "1 init_tripsh July 2018 to Dec 2018.csv"

## The new format files are stacked by data table type with six months of data. We want files for each month.
echo "extracting new veh_stoph months"
xsv search "JUL2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_07.csv
xsv search "AUG2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_08.csv
xsv search "SEP2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_09.csv
xsv search "OCT2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_10.csv
xsv search "NOV2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_11.csv
xsv search "DEC2018" new_raw_veh_stoph.csv > raw_veh_stoph_2018_12.csv

echo "extracting new stop_event months"
xsv search "JUL2018" new_raw_stop_event.csv > raw_stop_event_2018_07.csv
xsv search "AUG2018" new_raw_stop_event.csv > raw_stop_event_2018_08.csv
xsv search "SEP2018" new_raw_stop_event.csv > raw_stop_event_2018_09.csv
xsv search "OCT2018" new_raw_stop_event.csv > raw_stop_event_2018_10.csv
xsv search "NOV2018" new_raw_stop_event.csv > raw_stop_event_2018_11.csv
xsv search "DEC2018" new_raw_stop_event.csv > raw_stop_event_2018_12.csv

echo "extracting new tripsh months"
xsv search "JUL2018" new_raw_tripsh.csv > raw_tripsh_2018_07.csv
xsv search "AUG2018" new_raw_tripsh.csv > raw_tripsh_2018_08.csv
xsv search "SEP2018" new_raw_tripsh.csv > raw_tripsh_2018_09.csv
xsv search "OCT2018" new_raw_tripsh.csv > raw_tripsh_2018_10.csv
xsv search "NOV2018" new_raw_tripsh.csv > raw_tripsh_2018_11.csv
xsv search "DEC2018" new_raw_tripsh.csv > raw_tripsh_2018_12.csv

rm new_raw_*.csv

popd

## And we're done! We have:

## the passenger stop event tables
### raw_stop_event_2017_09.csv
### raw_stop_event_2017_10.csv
### raw_stop_event_2017_11.csv
### raw_stop_event_2018_04.csv
### raw_stop_event_2018_05.csv
### raw_stop_event_2018_07.csv
### raw_stop_event_2018_08.csv
### raw_stop_event_2018_09.csv
### raw_stop_event_2018_10.csv
### raw_stop_event_2018_11.csv
### raw_stop_event_2018_12.csv

## the trips history tables
### raw_tripsh_2017_09.csv
### raw_tripsh_2017_10.csv
### raw_tripsh_2017_11.csv
### raw_tripsh_2018_04.csv
### raw_tripsh_2018_05.csv
### raw_tripsh_2018_07.csv
### raw_tripsh_2018_08.csv
### raw_tripsh_2018_09.csv
### raw_tripsh_2018_10.csv
### raw_tripsh_2018_11.csv
### raw_tripsh_2018_12.csv

## the vehicle stop history tables
### raw_veh_stoph_2017_09.csv
### raw_veh_stoph_2017_10.csv
### raw_veh_stoph_2017_11.csv
### raw_veh_stoph_2018_04.csv
### raw_veh_stoph_2018_05.csv
### raw_veh_stoph_2018_07.csv
### raw_veh_stoph_2018_08.csv
### raw_veh_stoph_2018_09.csv
### raw_veh_stoph_2018_10.csv
### raw_veh_stoph_2018_11.csv
### raw_veh_stoph_2018_12.csv
