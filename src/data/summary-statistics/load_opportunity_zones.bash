#! /bin/bash

ogr2ogr -lco precision=NO -nlt PROMOTE_TO_MULTI -t_srs EPSG:4326 -overwrite PG:"dbname=transit_operations_analytics_data" /vsizip/8764OpportunityZones7-19-2019.zip
