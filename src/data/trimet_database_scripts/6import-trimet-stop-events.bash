#! /bin/bash

# define parameters
export DBOWNER=transportation-systems
export PGDATABASE=transportation-systems-trimet

echo "Creating the 'trimet_stop_events' (congestion data) table"
/usr/bin/time psql -f trimet-stop-events.psql
