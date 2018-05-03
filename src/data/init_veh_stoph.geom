-- create a geometry from the gps_longitude and gps_latitude values in SRID 4326
ALTER TABLE init_veh_stoph
  DROP COLUMN IF EXISTS geom_4326;
ALTER TABLE init_veh_stoph
  ADD COLUMN geom_4326 geometry;
UPDATE init_veh_stoph
  SET geom_4326 = ST_SetSRID(ST_MakePoint(gps_longitude, gps_latitude), 4326);
