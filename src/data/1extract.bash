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
echo "Standardizing date stamps"
/usr/bin/time sed --in-place=_bak --expression='s/\([0-9][0-9]\)SEP2017:00:00:00/2017-09-\1/' *SEP2017.csv
/usr/bin/time sed --in-place=_bak --expression='s/\([0-9][0-9]\)OCT2017:00:00:00/2017-10-\1/' *OCT2017.csv
/usr/bin/time sed --in-place=_bak --expression='s/\([0-9][0-9]\)NOV2017:00:00:00/2017-11-\1/' *NOV2017.csv
/usr/bin/time sed --in-place=_bak --expression='s/\([0-9][0-9]\)APR2018:00:00:00/2018-04-\1/' *APR2018.csv
/usr/bin/time sed --in-place=_bak --expression='s/\([0-9][0-9]\)MAY2018:00:00:00/2018-05-\1/' *MAY2018.csv
popd
