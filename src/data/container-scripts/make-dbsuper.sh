#! /bin/bash

createuser --superuser $TOAD_USER || true
createdb --owner=$TOAD_USER $TOAD_DB || true
psql --username=$TOAD_USER --dbname=$TOAD_DB --command="ALTER USER $TOAD_USER WITH PASSWORD '$POSTGRES_PASSWORD';"
psql --username=$TOAD_USER --dbname=$TOAD_DB --command="CREATE EXTENSION postgis CASCADE;"
