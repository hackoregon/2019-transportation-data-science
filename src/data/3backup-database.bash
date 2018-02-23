#! /bin/bash

# define parameters
export interim="../../data/interim"
export PGDATABASE=trimet_congestion
export backups=${interim}/backups
export JOBS=7 # one less than your processor / thread count - a four-core / eight-thread would use seven

# rclone requires a directory for bulk uploads
mkdir -p ${backups}

/usr/bin/time pg_dump --format=directory --jobs=${JOBS} \
  --file=${backups}/trimet_congestion.backup $PGDATABASE
