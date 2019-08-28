DROP TABLE IF EXISTS current_stop_locations;
CREATE TABLE current_stop_locations AS
SELECT DISTINCT stop_id, ST_X(wkb_geometry) AS longitude, ST_Y(wkb_geometry) AS latitude,
  wkb_geometry AS geom_point_4326
FROM trimet_gis.tm_route_stops
ORDER BY stop_id;

DROP TABLE IF EXISTS old_stop_locations;
CREATE TABLE old_stop_locations AS
  SELECT 
    location_id AS stop_id, 
    percentile_cont(0.50) within group (order by longitude) AS longitude,
    percentile_cont(0.50) within group (order by latitude) AS latitude,
    ST_SetSRID(ST_MakePoint(
      percentile_cont(0.50) within group (order by longitude),
      percentile_cont(0.50) within group (order by latitude)
    ), 4326) AS geom_point_4326
  FROM bus_passenger_stops
  WHERE location_id NOT IN (SELECT stop_id FROM current_stop_locations)
  GROUP BY bus_passenger_stops.location_id
  UNION SELECT 
    location_id AS stop_id, 
    percentile_cont(0.50) within group (order by longitude) AS longitude,
    percentile_cont(0.50) within group (order by latitude) AS latitude,
    ST_SetSRID(ST_MakePoint(
      percentile_cont(0.50) within group (order by longitude),
      percentile_cont(0.50) within group (order by latitude)
    ), 4326) AS geom_point_4326
  FROM rail_passenger_stops
  WHERE location_id NOT IN (SELECT stop_id FROM current_stop_locations)
  GROUP BY rail_passenger_stops.location_id
;

DROP TABLE IF EXISTS passenger_stop_locations;
CREATE TABLE passenger_stop_locations AS
SELECT * FROM current_stop_locations
UNION SELECT * FROM old_stop_locations
ORDER BY stop_id
;
ALTER TABLE passenger_stop_locations ADD PRIMARY KEY (stop_id);
ALTER TABLE passenger_stop_locations
  ALTER COLUMN geom_point_4326 TYPE geometry(POINT, 4326)
    USING ST_SetSRID(geom_point_4326, 4326)
;
