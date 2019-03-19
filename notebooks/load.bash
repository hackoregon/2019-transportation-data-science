#! /bin/bash

psql -p 5440 -d postgres -f create_database.sql
psql -p 5440 -d transit_operations_analytics_data -f create_foreign_tables.sql
