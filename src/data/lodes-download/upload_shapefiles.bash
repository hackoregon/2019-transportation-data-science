for i in tl*zip
do 
  echo $i
  ogr2ogr -lco precision=NO -nlt PROMOTE_TO_MULTI -overwrite -t_srs EPSG:4326 \
    PG:dbname=transit_operations_analytics_data /vsizip/$i
done

for i in tm*zip
do 
  echo $i
  if [ "$i" == "tm_routes.zip" ]
  then
    ogr2ogr -lco precision=NO -nlt PROMOTE_TO_MULTI -overwrite -t_srs EPSG:4326 \
      PG:dbname=transit_operations_analytics_data /vsizip/$i
  else
    ogr2ogr -lco precision=NO -overwrite -t_srs EPSG:4326 \
      PG:dbname=transit_operations_analytics_data /vsizip/$i
  fi
done
