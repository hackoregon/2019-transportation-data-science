# SQLITE Toad
Here's a collection of the python scripts I used to:
1) create the toad database in sqlite
2) query that database for the hawthorne dataset.

Usage of these scripts requires access to the raw data dump. File locations should be modified in the `db_config.json`

## make_toad_db.py
This script will create the `init_veh_stoph` and `trimet_stop_events` tables for both the 'old' and 'new' data formats. Currently everything is set to run out of this directory, so keep that in mind. I'm putting these here more for reference.

NOTE: This scripts takes a good little while, maybe 20 minutes or so?

The output will be `old_raw.db` and `new_raw.db` sqlite files. (They are ~11 gb each).

## make_hawthorne_disturbance.csv
This script will run a query against the `old_raw.db` and `new_raw.db` files to produce csv files of the hawthorne corridor.

BE WARNED! This script can take a long time. Like, an hour and a half. I've seen it run as fast as 30 min or so, but yeah it will take a while. 

The output will be `old_disturbance.csv` and `new_disturbance.csv` files.
