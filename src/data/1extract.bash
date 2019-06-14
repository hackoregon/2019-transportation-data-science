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
unzip   "${RAW}/July+2018+to+Dec+2018.zip" "*init_tripsh*.csv" "*init_veh_stoph*.csv" "*stopevent*.csv"

echo "Standardizing date formats and dropping months outside Sep-Nov"
for file in *July*csv
do
  echo "JUL ${file}"; sed -i '/JUL18/d' "${file}"
  echo "AUG ${file}"; sed -i '/AUG18/d' "${file}"
  echo "DEC ${file}"; sed -i '/DEC18/d' "${file}"
  echo "2018 ${file}"; sed -i 's/18:00:00:00/2018:00:00:00/' "${file}"
done

# document headers
head -n 1 *tripsh*  > tripsh_headers.txt
head -n 1 *stopevent* ${CSVS}/*stop_event* > stop_event_headers.txt
head -n 1 *veh_stoph*  > veh_stoph_headers.txt

popd
