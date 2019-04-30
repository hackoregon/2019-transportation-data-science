#! /bin/bash

# wait-for-postgres.sh
# https://docs.docker.com/compose/startup-order/

# http://linuxcommand.org/lc3_man_pages/seth.html:
# -e  Exit immediately if a command exits with a non-zero status.
set -e

export PGPASSWORD=$POSTGRES_PASSWORD
until psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -p "$POSTGRES_PORT" -d postgres -c '\q'
do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 5
done

>&2 echo "Postgres is up"
echo Debug: $DEBUG
# Collect static files
echo "Collect static files"
python -Wall manage.py collectstatic --noinput

echo "Make migrations"
python -Wall manage.py makemigrations

echo "Migrate"
python -Wall manage.py migrate

echo "Run server..."
python -Wall manage.py runserver 0.0.0.0:8000
