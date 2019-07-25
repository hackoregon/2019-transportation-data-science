#! /bin/bash

createuser --superuser dbsuper || true
createdb --owner=dbsuper dbsuper || true
command="ALTER USER dbsuper WITH PASSWORD '${POSTGRES_PASSWORD}';"
psql --command "$command"
