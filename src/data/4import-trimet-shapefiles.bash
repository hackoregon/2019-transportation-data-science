#! /bin/bash

# define parameters
export DBOWNER=postgres
export PGDATABASE=transit_operations_analytics_data

echo "Importing ***current*** TriMet shapefiles"
pushd /tmp
export WHERE=https://developer.trimet.org/gis/data
for table in tm_boundary tm_parkride tm_rail_lines tm_rail_stops tm_routes tm_stops tm_route_stops tm_tran_cen
do
  echo "Importing ${table}"
  wget -nc -q $WHERE/${table}.zip
  rm -fr ${table}; mkdir $table; cd $table
  unzip -qq ../${table}.zip
  ogr2ogr -f PostgreSQL -lco PRECISION=NO -nlt PROMOTE_TO_MULTI \
    PG:"dbname=${PGDATABASE}" ${table}.shp
  psql -d ${PGDATABASE} -c "ALTER TABLE ${table} OWNER TO \"${DBOWNER}\";"
  cd ..
done
popd
