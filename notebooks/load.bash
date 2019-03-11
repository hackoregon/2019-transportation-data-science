#! /bin/bash

psql -d postgres -f create_database.sql
psql -d transit_operations_analytics_data -f create_tables.sql
psql -d transit_operations_analytics_data -f copy_tables.sql
