-- delete unwanted rows
DELETE FROM :trimet_stop_event
  WHERE service_key IS NULL 
  OR route_number IS NULL
  OR service_key != 'W'
  OR route_number > 291
  OR route_number < 1
;

-- drop unwanted columns
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS badge;
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS maximum_speed;
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS pattern_distance;
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS location_distance;
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS data_source;
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS schedule_status;

-- make a usable date stamp
ALTER TABLE :trimet_stop_event ADD COLUMN date_stamp date;
UPDATE :trimet_stop_event SET date_stamp = to_date(service_date, 'DDMONYY');
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS service_date;

-- index the variables that define events
CREATE INDEX ON :trimet_stop_event (date_stamp);
CREATE INDEX ON :trimet_stop_event (vehicle_number);
CREATE INDEX ON :trimet_stop_event (leave_time);
CREATE INDEX ON :trimet_stop_event (route_number);
CREATE INDEX ON :trimet_stop_event (direction);
CREATE INDEX ON :trimet_stop_event (arrive_time);
CREATE INDEX ON :trimet_stop_event (location_id);

-- add geometry column and index
ALTER TABLE :trimet_stop_event ADD COLUMN geom_point_4326 geometry;
UPDATE :trimet_stop_event
  SET geom_point_4326 = ST_Transform(ST_SetSRID(ST_Point(x_coordinate, y_coordinate), 2913), 4326);
CREATE INDEX ON :trimet_stop_event USING GIST (geom_point_4326);
