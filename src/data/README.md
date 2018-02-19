## About the data
The raw dataset is on a “.rar” archive. This is an unusual choice for an archive format, but there is a Linux utility “unrar” that can extract the files. That yields 12 CSV files:

    5.8G    init_cyclic_v1h 1-30NOV2017.csv
    3.3G    init_cyclic_v1h 1-30SEP2017.csv
    6.0G    init_cyclic_v1h 1-31OCT2017.csv
    27M     init_tripsh 1-30NOV2017.csv
    27M     init_tripsh 1-30SEP2017.csv
    28M     init_tripsh 1-31OCT2017.csv
    1.6G    init_veh_stoph 1-30NOV2017.csv
    1.5G    init_veh_stoph 1-30SEP2017.csv
    1.6G    init_veh_stoph 1-31OCT2017.csv
    1.2G    trimet_stop_event 1-30NOV2017.csv
    1.2G    trimet_stop_event 1-30SEP2017.csv
    1.3G    trimet_stop_event 1-31OCT2017.csv

There’s an obvious pattern here: a table name, followed by a space, then a “1-” and the last day of the month. There are four table types and three months, giving the 12 CSV files.

How many lines / rows are there in each file?

    ```
        Rows File
    69265064 init_cyclic_v1h 1-30NOV2017.csv
    39544465 init_cyclic_v1h 1-30SEP2017.csv
    71874174 init_cyclic_v1h 1-31OCT2017.csv
      182295 init_tripsh 1-30NOV2017.csv
      179523 init_tripsh 1-30SEP2017.csv
      190685 init_tripsh 1-31OCT2017.csv
    11169195 init_veh_stoph 1-30NOV2017.csv
    11031282 init_veh_stoph 1-30SEP2017.csv
    11667533 init_veh_stoph 1-31OCT2017.csv
     9946818 trimet_stop_event 1-30NOV2017.csv
     9761796 trimet_stop_event 1-30SEP2017.csv
    10361905 trimet_stop_event 1-31OCT2017.csv
    ```

In my script, each CSV file lands in its own table, with a table name of the form `ended_<date>_<table type>`. For example, `init_cyclic_v1h 1-31OCT2017.csv` lands in table `ended_20171031_init_cyclic_v1h`. The alternative, concatenating the files into just four tables, would take a lot longer.

In addition to loading the raw data into the database, the script also creates a compressed backup of each table and of the whole database.

    682M    ended_20170930_init_cyclic_v1h.backup
    6.3M    ended_20170930_init_tripsh.backup
    492M    ended_20170930_init_veh_stoph.backup
    330M    ended_20170930_trimet_stop_event.backup
    1.3G    ended_20171031_init_cyclic_v1h.backup
    6.7M    ended_20171031_init_tripsh.backup
    520M    ended_20171031_init_veh_stoph.backup
    350M    ended_20171031_trimet_stop_event.backup
    1.2G    ended_20171130_init_cyclic_v1h.backup
    6.4M    ended_20171130_init_tripsh.backup
    498M    ended_20171130_init_veh_stoph.backup
    335M    ended_20171130_trimet_stop_event.backup
    5.6G    trimet_congestion.backup

## About the code
This process uses the Cookiecutter Data Science conventions:

    1. Raw data is immutable. The `.rar` archive is in `../../data/raw`.
    2. The outputs of this process are in `../../data/interim`.

Script `create-database.bash` runs the database creation. You will need:

* Linux - there is no plan to port this to other operating systems, although I do plan to make it run in a Docker container.
* The Linux utility `/usr/bin/time`. This is sometimes included in the base Linux install, but you may have to install a package to get it.
* `unrar` to unpack the `.rar` archive.
* A `postgresql` server somewhere. It must be release 10.1 or later. It does *not* need PostGIS; the script just copies the raw CSV data into tables. You will need a login role to the server with at least `CREATE DATABASE` privileges, but you don't need to be a superuser.
* `postgresql` *client* utilities on the machine where you run the script. You will need to set the connection environment variables:

    * PGHOST: the name or IP address of server
    * PGPORT: the port the server listens on, usually 5432
    * PGUSER: your login role
    * PGPASSWORD: the password for the login role

* Patience - this is a huge dataset. See above for the scale of the data.

The script is a straightforward double-nested loop. The outer loop is over dates (the three months) and the inner loop is over the four table types. For each month - table type pair, the script:

    1. creates the table using a DDL template called `<table_type>.ddl`,
    2. loads the data with a `psql` `\copy`,
    3. does a `VACUUM ANALYZE` on the table, and
    4. creates a backup of the table with `pg_dump`.

At the end, the script creates a backup of the whole database with `pg_dump`.
