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
for file in *.csv *.txt
do
  /usr/bin/time dos2unix ${file}
done
popd
