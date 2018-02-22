#! /bin/bash

# define parameters
export filedates=("1-30SEP2017" "1-31OCT2017" "1-30NOV2017")
export tabledates=("ended_20170930" "ended_20171031" "ended_20171130")
export tablenames=("init_cyclic_v1h" "init_veh_stoph" "trimet_stop_event" "init_tripsh")
export raw="../../data/raw"
export interim="../../data/interim"
export PGDATABASE=trimet_congestion

# unpack the raw data
pushd ${interim}
echo "Unpacking the archive"
/usr/bin/time unrar e -inul ../raw/scrapes.rar
popd

# create a fresh database
dropdb ${PGDATABASE} || true
sudo du -sh /var/lib/postgres/data # size before loading data
createdb ${PGDATABASE}

# load the tables
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

    # run the ddl
    sed "s;ENDDATE;${tabledate};" ${tablename}.ddl | psql

    # run the copy
    export copy_command="\copy ${db_tablename} from '${interim}/${filename}' with csv header"
    echo "${copy_command}"
    /usr/bin/time psql -c "${copy_command}"
    psql -c "VACUUM ANALYZE ${db_tablename};"

  done
done

# measure size after we load data
sudo du -sh /var/lib/postgres/data
