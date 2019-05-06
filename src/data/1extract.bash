#! /bin/bash

# set directories
export RAW="${HOME}/Raw/"
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

# document headers
head -n 1 *tripsh*  > tripsh_headers.txt
head -n 1 *stopevent* ${CSVS}/*stop_event* > stop_event_headers.txt
head -n 1 *veh_stoph*  > veh_stoph_headers.txt

popd
