#! /bin/bash

# http://linuxcommand.org/lc3_man_pages/seth.html:
# -e  Exit immediately if a command exits with a non-zero status.
set -e

echo Debug: $DEBUG

# Pull in environment variables values from AWS Parameter Store, and preserve the exports
# source usage per https://stackoverflow.com/q/14742358/452120
source /code/bin/get-ssm-parameters.sh

python -Wall manage.py collectstatic --noinput

gunicorn $PROJECT_NAME.wsgi -c gunicorn_config.py
