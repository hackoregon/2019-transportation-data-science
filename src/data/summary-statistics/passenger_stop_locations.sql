DROP TABLE IF EXISTS passenger_stop_locations;
CREATE TABLE passenger_stop_locations AS
SELECT DISTINCT stop_id, stop_name, 
  ST_X(wkb_geometry) AS longitude, ST_Y(wkb_geometry) AS latitude,
  wkb_geometry AS geom_point_4326
FROM trimet_gis.tm_route_stops
ORDER BY stop_id;

ALTER TABLE passenger_stop_locations ADD PRIMARY KEY (stop_id);
ALTER TABLE passenger_stop_locations
  ALTER COLUMN geom_point_4326 TYPE geometry(POINT, 4326)
    USING ST_SetSRID(geom_point_4326, 4326)
;
