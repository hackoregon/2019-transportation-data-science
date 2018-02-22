-- create a geometry from the gps_longitude and gps_latitude values in SRID 4326
ALTER TABLE ENDDATE_init_cyclic_v1h
  ADD COLUMN geom_4326 geometry;
UPDATE ENDDATE_init_cyclic_v1h
  SET geom_4326 = ST_SetSRID(ST_MakePoint(gps_longitude, gps_latitude), 4326);
