#! /bin/bash

# define parameters
export filedates=("1-30SEP2017" "1-31OCT2017" "1-30NOV2017")
export tabledates=("ended_20170930" "ended_20171031" "ended_20171130")
export tablenames=("init_cyclic_v1h" "init_veh_stoph" "trimet_stop_event" "init_tripsh")
export raw="../../data/raw"
export interim="../../data/interim"
export PGDATABASE=trimet_congestion
export backups=${interim}/backups
export JOBS=7 # one less than your processor / thread count - a four-core / eight-thread would use seven

# rclone requires a directory for bulk uploads
mkdir -p ${backups}

/usr/bin/time pg_dump --format=directory --jobs=${JOBS} --no-owner --clean --if-exists \
  --file=${backups}/trimet_congestion.backup $PGDATABASE
