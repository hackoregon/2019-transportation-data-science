ALTER TABLE init_veh_stoph ADD COLUMN geom_point_4326 geometry;
UPDATE init_veh_stoph
  SET geom_point_4326 = ST_SetSRID(ST_Point(gps_longitude, gps_latitude), 4326);

ALTER TABLE trimet_stop_event ADD COLUMN geom_point_4326 geometry;
UPDATE trimet_stop_event
  SET geom_point_4326 = ST_Transform(ST_SetSRID(ST_Point(x_coordinate, y_coordinate), 2913), 4326);
