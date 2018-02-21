#! /bin/bash -v

export interim="../../data/interim"
export PGDATABASE=trimet_congestion
export JOBS=6 # two less than your processor / thread count - a four-core / eight-thread would use six

# rclone requires a directory for bulk uploads
mkdir -p ${interim}/backups

/usr/bin/time pg_dump --format=directory --jobs=${JOBS} --no-owner --clean --if-exists \
  --file=${interim}/backups/trimet_congestion_backup $PGDATABASE

# individual files are compressed - compressing with zip is a waste of time
/usr/bin/time zip -0r trimet_congestion_backup.zip trimet_congestion_backup
