#! /bin/bash

# define parameters
export DBOWNER=transportation2019
export PGUSER=transportation2019
export PGDATABASE=transit_operations_analytics_data

echo "Loading TriMet and Census reference data"
for schema in trimet_gis census_gis
do
  echo "Creating schema ${schema}"
  psql -U ${DBOWNER} -d ${PGDATABASE} -c "DROP SCHEMA IF EXISTS ${schema} CASCADE;"
  psql -U ${DBOWNER} -d ${PGDATABASE} -c "CREATE SCHEMA ${schema};"
done

pushd /Raw
echo "Importing TriMet shapefiles"
schema=trimet_gis
for zipfile in \
  https://developer.trimet.org/gis/data/tm_boundary.zip \
  https://developer.trimet.org/gis/data/tm_parkride.zip \
  https://developer.trimet.org/gis/data/tm_rail_lines.zip \
  https://developer.trimet.org/gis/data/tm_rail_stops.zip \
  https://developer.trimet.org/gis/data/tm_routes.zip \
  https://developer.trimet.org/gis/data/tm_stops.zip \
  https://developer.trimet.org/gis/data/tm_route_stops.zip \
  https://developer.trimet.org/gis/data/tm_tran_cen.zip
do
  echo "Downloading ${zipfile}"
  wget -nc -q ${zipfile}
  table=`echo ${zipfile} | sed 's;^.*/;;' | sed 's;.zip$;;'`

  # in theory, ogr2ogr can import zipped shapefiles directly but older versions may not work
  rm -fr ${table}; mkdir $table; cd $table
  unzip -qq ../${table}.zip

  echo "Creating table '${table}' in the '${schema}' schema"
  ogr2ogr -f PostgreSQL -overwrite -lco PRECISION=NO -nlt PROMOTE_TO_MULTI \
    -lco SCHEMA=${schema} PG:"dbname=${PGDATABASE}" ${table}.shp
  psql -U ${DBOWNER} -d ${PGDATABASE} -c "ALTER TABLE ${schema}.${table} OWNER TO \"${DBOWNER}\";"
  cd ..
done

echo "Importing TIGER/Line® shapefiles"
schema=census_gis
for zipfile in \
  ftp://ftp2.census.gov/geo/tiger/TIGER2018/BG/tl_2018_41_bg.zip \
  ftp://ftp2.census.gov/geo/tiger/TIGER2018/TABBLOCK/tl_2018_41_tabblock10.zip \
  ftp://ftp2.census.gov/geo/tiger/TIGER2018/TRACT/tl_2018_41_tract.zip
do
  echo "Downloading ${zipfile}"
  wget -nc -q ${zipfile}
  table=`echo ${zipfile} | sed 's;^.*/;;' | sed 's;.zip$;;'`
  rm -fr ${table}; mkdir $table; cd $table
  unzip -qq ../${table}.zip
  echo "Creating table '${table}' in the '${schema}' schema"
  ogr2ogr -f PostgreSQL -overwrite -lco PRECISION=NO -nlt PROMOTE_TO_MULTI \
    -lco SCHEMA=${schema} PG:"dbname=${PGDATABASE}" ${table}.shp
  psql -U ${DBOWNER} -d ${PGDATABASE} -c "ALTER TABLE ${schema}.${table} OWNER TO \"${DBOWNER}\";"
  cd ..
done
popd
