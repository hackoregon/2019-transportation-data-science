#! /bin/bash

# define parameters
export BASE=https://lehd.ces.census.gov/data/lodes/LODES7
export DESTINATION=/Work/LODES
mkdir -p ${DESTINATION}; pushd ${DESTINATION}

if [ ! -e "lodes_or.sha256sum" ]
then 
  for state in or
  do

    echo "${state}_xwalk"
    wget -nc ${BASE}/${state}/${state}_xwalk.csv.gz
    gzip -dc ${state}_xwalk.csv.gz > ${state}_xwalk.csv

    for year in 2015
    do

      for segment in od_main od_aux \
        wac_S000 rac_S000 \
        wac_SA01 wac_SA02 wac_SA03 \
        wac_SE01 wac_SE02 wac_SE03 \
        wac_SI01 wac_SI02 wac_SI03 \
        rac_SA01 rac_SA02 rac_SA03 \
        rac_SE01 rac_SE02 rac_SE03 \
        rac_SI01 rac_SI02 rac_SI03
      do

        folder=`echo ${segment} | sed 's;_.*$;;'`
        echo "${state} ${year} ${segment} ${folder}"

        for jobtype in JT00 JT01 JT02 JT03 JT04 JT05
        do
            wget -nc ${BASE}/${state}/${folder}/${state}_${segment}_${jobtype}_${year}.csv.gz
            gzip -dc ${state}_${segment}_${jobtype}_${year}.csv.gz > ${state}_${segment}_${jobtype}_${year}.csv
        done

      done # segment
    done # year
  
    wget -nc ${BASE}/${state}/lodes_${state}.sha256sum

  done # state
fi
echo "Checking sha256 sums"
for state in or
do
  sha256sum --ignore-missing -c lodes_${state}.sha256sum
done

popd
source $CONDA_ACTIVATION_SCRIPT
which python3
python3 make_dataset_lodes.py
