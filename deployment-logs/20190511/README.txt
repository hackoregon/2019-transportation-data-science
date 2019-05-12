pg_restore.log: log file from the restore
README.txt: this file
restore.bash: script that does the restore
restore.log: log file from the bash run of restore.bash
sarlog.txt: sar log from S3 fetch and RDS restore - get time stamps from restore.log
vaccsarlog.txt: sar log from VACUUM - mostly meaningless; all the work is done in the S3 instance
vacuum.bash: vacuum script
