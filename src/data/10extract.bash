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
unar -D  "${RAW}/scrapes.rar" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"
unar -D  "${RAW}/April 2018.rar" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"
unar -D  "${RAW}/May 2018.rar" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"
unzip -o "${RAW}/July+2018+to+Dec+2018.zip" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*stopevent*.csv"

## Madison / 4th data received 2019-07-31 and 2019-08-08
unzip -o "${RAW}/Madison4th.zip" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"
unzip -o "${RAW}/Mad4th+0725-3119.zip" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*trimet_stop_event*.csv"

## August 2019 data received 2019-09-04
unzip -o "${RAW}/August+2019.zip"

## We use "xsv" (https://github.com/BurntSushi/xsv) to standardize the CSV files for input to data science and
## database loading processes. It's available in some Linux distros, but we use the binary release since it's not in
## Debian "stretch".
echo "defining the columns to retain"
export VEH_STOPH_COLS=EVENT_NO_TRIP,OPD_DATE,VEHICLE_ID,METERS,ACT_ARR_TIME,ACT_DEP_TIME,NOM_ARR_TIME,NOM_DEP_TIME,STOP_ID,STOP_POS,DISTANCE_TO_NEXT,DISTANCE_TO_TRIP,DOORS_OPENING,STOP_TYPE,GPS_LONGITUDE,GPS_LATITUDE,DOOR_OPEN_TIME
export STOP_EVENT_COLS=SERVICE_DATE,VEHICLE_NUMBER,LEAVE_TIME,TRAIN,ROUTE_NUMBER,DIRECTION,SERVICE_KEY,TRIP_NUMBER,STOP_TIME,ARRIVE_TIME,DWELL,LOCATION_ID,DOOR,LIFT,ONS,OFFS,ESTIMATED_LOAD,TRAIN_MILEAGE,X_COORDINATE,Y_COORDINATE
export TRIPSH_COLS=OPD_DATE,VEHICLE_ID,EVENT_NO,METERS,ACT_DEP_TIME,NOM_DEP_TIME,NOM_END_TIME,ACT_END_TIME,LINE_ID,PATTERN_DIRECTION

## Each month contains four files. There is a large file ("cyclic") which contains all timestamped vehicle positions.
## It appears to contain only buses, and we do not use it. Some months have a "breadcrumbs" file, which we do not use.
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

## Processing the "Madison4th" files
## On 2019-07-31, we received a new dataset covering April 1, 2019 through July 24, 2019. We call this dataset the
## 'Madison4th' dataset. The date stamps and file names correspond to the "old" format data (fall 2017), but the
## archive format is ".zip" and all months are concatenated. There is both a "cyclic" and a "breadcrumbs" file in this
## dataset, neither of which we are using. On 2019-08-08 we received the rest of July 2019.
echo "'Madison4th' veh_stoph column selection"
xsv cat rows "Madison4th/init_veh_stoph.csv" "Mad4th 0725-3119/init_veh_stoph 0725to3119.csv" \
  | xsv select ${VEH_STOPH_COLS} > mad4th_raw_veh_stoph.csv
echo "'Madison4th' stop_event column selection"
xsv cat rows "Madison4th/trimet_stop_event.csv" "Mad4th 0725-3119/trimet_stop_event 0725to3119.csv" \
  | xsv select ${STOP_EVENT_COLS} > mad4th_raw_stop_event.csv
echo "'Madison4th' tripsh column selection"
xsv cat rows "Madison4th/init_tripsh.csv" "Mad4th 0725-3119/init_tripsh 0725to3119.csv" \
  | xsv select ${TRIPSH_COLS} > mad4th_raw_tripsh.csv
echo "'Madison4th' veh_stoph month extraction"
xsv search "APR2019" mad4th_raw_veh_stoph.csv > raw_veh_stoph_2019_04.csv
xsv search "MAY2019" mad4th_raw_veh_stoph.csv > raw_veh_stoph_2019_05.csv
xsv search "JUN2019" mad4th_raw_veh_stoph.csv > raw_veh_stoph_2019_06.csv
xsv search "JUL2019" mad4th_raw_veh_stoph.csv > raw_veh_stoph_2019_07.csv

echo "'Madison4th' stop_event month extraction"
xsv search "APR2019" mad4th_raw_stop_event.csv > raw_stop_event_2019_04.csv
xsv search "MAY2019" mad4th_raw_stop_event.csv > raw_stop_event_2019_05.csv
xsv search "JUN2019" mad4th_raw_stop_event.csv > raw_stop_event_2019_06.csv
xsv search "JUL2019" mad4th_raw_stop_event.csv > raw_stop_event_2019_07.csv

echo "'Madison4th' tripsh month extraction"
xsv search "APR2019" mad4th_raw_tripsh.csv > raw_tripsh_2019_04.csv
xsv search "MAY2019" mad4th_raw_tripsh.csv > raw_tripsh_2019_05.csv
xsv search "JUN2019" mad4th_raw_tripsh.csv > raw_tripsh_2019_06.csv
xsv search "JUL2019" mad4th_raw_tripsh.csv > raw_tripsh_2019_07.csv

## Processing the old format files is easy - we only need to select the columns we're using
echo "old format vehicle stop history"
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-30SEP2017.csv" > raw_veh_stoph_2017_09.csv
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-31OCT2017.csv" > raw_veh_stoph_2017_10.csv
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-30NOV2017.csv" > raw_veh_stoph_2017_11.csv
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-30APR2018.csv" > raw_veh_stoph_2018_04.csv
xsv select ${VEH_STOPH_COLS} "init_veh_stoph 1-31MAY2018.csv" > raw_veh_stoph_2018_05.csv
xsv select ${VEH_STOPH_COLS} "init_veh_stoph Aug 2019.csv"    > raw_veh_stoph_2019_08.csv
rm "init_veh_stoph 1-30SEP2017.csv"
rm "init_veh_stoph 1-31OCT2017.csv"
rm "init_veh_stoph 1-30NOV2017.csv"
rm "init_veh_stoph 1-30APR2018.csv"
rm "init_veh_stoph 1-31MAY2018.csv"
rm "init_veh_stoph Aug 2019.csv"

echo "old format stop events"
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-30SEP2017.csv" > raw_stop_event_2017_09.csv
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-31OCT2017.csv" > raw_stop_event_2017_10.csv
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-30NOV2017.csv" > raw_stop_event_2017_11.csv
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-30APR2018.csv" > raw_stop_event_2018_04.csv
xsv select ${STOP_EVENT_COLS} "trimet_stop_event 1-31MAY2018.csv" > raw_stop_event_2018_05.csv
xsv select ${STOP_EVENT_COLS} "trimet_stop_event Aug 2019.csv"    > raw_stop_event_2019_08.csv
rm "trimet_stop_event 1-30SEP2017.csv"
rm "trimet_stop_event 1-31OCT2017.csv"
rm "trimet_stop_event 1-30NOV2017.csv"
rm "trimet_stop_event 1-30APR2018.csv"
rm "trimet_stop_event 1-31MAY2018.csv"
rm "trimet_stop_event Aug 2019.csv"

echo "old format trips history"
xsv select ${TRIPSH_COLS} "init_tripsh 1-30SEP2017.csv" > raw_tripsh_2017_09.csv
xsv select ${TRIPSH_COLS} "init_tripsh 1-31OCT2017.csv" > raw_tripsh_2017_10.csv
xsv select ${TRIPSH_COLS} "init_tripsh 1-30NOV2017.csv" > raw_tripsh_2017_11.csv
xsv select ${TRIPSH_COLS} "init_tripsh 1-30APR2018.csv" > raw_tripsh_2018_04.csv
xsv select ${TRIPSH_COLS} "init_tripsh 1-31MAY2018.csv" > raw_tripsh_2018_05.csv
xsv select ${TRIPSH_COLS} "init_tripsh Aug 2019.csv"    > raw_tripsh_2019_08.csv
rm "init_tripsh 1-30SEP2017.csv"
rm "init_tripsh 1-31OCT2017.csv"
rm "init_tripsh 1-30NOV2017.csv"
rm "init_tripsh 1-30APR2018.csv"
rm "init_tripsh 1-31MAY2018.csv"
rm "init_tripsh Aug 2019.csv"

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
### raw_stop_event_2019_04.csv
### raw_stop_event_2019_05.csv
### raw_stop_event_2019_06.csv
### raw_stop_event_2019_07.csv
### raw_stop_event_2019_08.csv

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
### raw_tripsh_2018_04.csv
### raw_tripsh_2018_05.csv
### raw_tripsh_2018_06.csv
### raw_tripsh_2018_07.csv
### raw_tripsh_2018_08.csv

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
### raw_veh_stoph_2019_04.csv
### raw_veh_stoph_2019_05.csv
### raw_veh_stoph_2019_06.csv
### raw_veh_stoph_2019_07.csv
### raw_veh_stoph_2019_08.csv
