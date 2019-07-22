#! /bin/bash

createuser --superuser dbsuper || true
createdb --owner=dbsuper dbsuper || true
