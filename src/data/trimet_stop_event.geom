-- create a geometry from the x_coordinate and y_coordinate values in SRID 2913
ALTER TABLE ENDDATE_trimet_stop_event
  ADD COLUMN geom_2913 geometry;
UPDATE ENDDATE_trimet_stop_event
  SET geom_2913 = ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913);
