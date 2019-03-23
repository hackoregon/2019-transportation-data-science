\echo adding indexed geometry column
ALTER TABLE :trimet_stop_event ADD COLUMN geom_point_4326 geometry;
UPDATE :trimet_stop_event
  SET geom_point_4326 = ST_Transform(ST_SetSRID(ST_Point(x_coordinate, y_coordinate), 2913), 4326);
CREATE INDEX ON :trimet_stop_event USING GIST (geom_point_4326);
