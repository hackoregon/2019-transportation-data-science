#!/bin/bash

# why do we need this?
# export PATH=$PATH:~/.local/bin

# http://linuxcommand.org/lc3_man_pages/seth.html:
# -e  Exit immediately if a command exits with a non-zero status.
set -e

echo Debug: $DEBUG

# Collect static files
echo "Collect static files"
python manage.py collectstatic --noinput

# have pytest run unit tests
pytest