#! /bin/bash

# define parameters
export filedates=("1-30SEP2017" "1-31OCT2017" "1-30NOV2017")
export tabledates=("ended_20170930" "ended_20171031" "ended_20171130")
export tablenames=("init_cyclic_v1h" "init_veh_stoph" "trimet_stop_event" "init_tripsh")
export raw="../../data/raw"
export interim="../../data/interim"
export PGDATABASE=trimet_congestion

for datex in 0 1 2
do
  filedate=${filedates[$datex]}
  tabledate=${tabledates[$datex]}
  for tablex in 0 1 2 3
  do
    tablename="${tablenames[$tablex]}"
    filename="${tablename} ${filedate}.csv"
    db_tablename="${tabledate}_${tablename}"
    echo "file: $filename => table: $db_tablename"

    # run the post-processing
    sed "s;ENDDATE;${tabledate};" ${tablename}.post | psql
    psql -c "VACUUM ANALYZE ${db_tablename};"

    # dump the table
    /usr/bin/time pg_dump --format=custom --no-owner --clean --if-exists --table=${db_tablename} \
      > ${interim}/${db_tablename}.backup

  done
done

# dump the whole database
/usr/bin/time pg_dump --format=custom --no-owner --clean --if-exists \
  > ${interim}/${PGDATABASE}.backup
