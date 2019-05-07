#! /bin/bash

psql --dbname=transit_operations_analytics_data --username=transportation2019 --command='\d+' > test.log
psql --dbname=transit_operations_analytics_data --username=transportation2019 --command='SELECT * FROM geometry_columns;' >> test.log
