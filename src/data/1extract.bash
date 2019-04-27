#! /bin/bash

# checksum input archives
export RAW="/home/znmeb/Raw/transportation-2018/transit-operations-analytics-data"
export CSVS=/csvs
echo "Checksumming raw archives"
pushd ${RAW}
sha512sum -c *.sha512sum
popd

# extract raw CSVs
echo "Extracting the CSVs"
sudo chown -R ${USER}:${USER} ${CSVS}
pushd ${CSVS}
rm *.csv
unrar x "${RAW}/scrapes.rar" "*.csv"
unrar x "${RAW}/April 2018.rar" "*.csv"
unrar x "${RAW}/May 2018.rar" "*.csv"
unzip   "${RAW}/July+2018+to+Dec+2018.zip"
popd

# document headers
head -n 1 ${CSVS}/*tripsh*  > tripsh_headers.txt
head -n 1 ${CSVS}/*stopevent* ${CSVS}/*stop_event* > stop_event_headers.txt
head -n 1 ${CSVS}/*veh_stoph*  > veh_stoph_headers.txt
head -n 1 ${CSVS}/*cyclic* ${CSVS}/*veh_bread* > cyclic_headers.txt
