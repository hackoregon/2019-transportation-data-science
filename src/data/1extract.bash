#! /bin/bash

# checksum input archives
export RAW="/home/znmeb/Raw/transportation-2018/transit-operations-analytics-data"
export CSVS=/csvs
echo "Checksumming raw archives"
pushd ${RAW}
/usr/bin/time sha512sum -c scrapes.rar.sha512sum
/usr/bin/time sha512sum -c April\ 2018.rar.sha512sum
/usr/bin/time sha512sum -c May\ 2018.rar.sha512sum
popd

# extract raw CSVs
echo "Extracting the CSVs"
pushd ${CSVS}
rm *.csv *.xlsx *.txt *.csv_bak
/usr/bin/time unrar x ${RAW}/scrapes.rar "*.csv"
/usr/bin/time unrar x ${RAW}/April\ 2018.rar "*.csv"
/usr/bin/time unrar x ${RAW}/May\ 2018.rar
popd
