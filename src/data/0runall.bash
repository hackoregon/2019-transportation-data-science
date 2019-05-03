#! /bin/bash

/usr/bin/time ./1extract.bash
/usr/bin/time ./2load.bash
/usr/bin/time ./3build_model.bash
/usr/bin/time ./8cleanup.bash
/usr/bin/time ./9create-database-backup.bash
