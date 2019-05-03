#! /bin/bash

/usr/bin/time ./1extract.bash
/usr/bin/time ./2load.bash
/usr/bin/time ./3build_model.bash
/usr/bin/time ./4geotag.bash
/usr/bin/time ./5cleanup.bash
/usr/bin/time ./9create-database-backup.bash
