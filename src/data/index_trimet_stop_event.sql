\echo deleting unwanted rows
DELETE FROM :trimet_stop_event
  WHERE service_key IS NULL 
  OR service_key != 'W'
  OR route_number IS NULL
  OR route_number > 291
  OR route_number < 1
;
-- MAX, Portland Streetcar and Aerial Tram
DELETE FROM :trimet_stop_event
  WHERE route_number = 90
  OR route_number = 100
  OR route_number = 190
  OR route_number = 193
  OR route_number = 194
  OR route_number = 195
  OR route_number = 200
  OR route_number = 208
  OR route_number = 290
;

\echo dropping unwanted columns
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS badge;
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS maximum_speed;
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS pattern_distance;
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS location_distance;
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS data_source;
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS schedule_status;

\echo making a usable date stamp
ALTER TABLE :trimet_stop_event ADD COLUMN date_stamp date;
UPDATE :trimet_stop_event SET date_stamp = to_date(service_date, 'DDMONYY');
ALTER TABLE :trimet_stop_event DROP COLUMN IF EXISTS service_date;

\echo indexing the variables that define events
CREATE INDEX ON :trimet_stop_event (date_stamp);
CREATE INDEX ON :trimet_stop_event (vehicle_number);
CREATE INDEX ON :trimet_stop_event (leave_time);
CREATE INDEX ON :trimet_stop_event (route_number);
CREATE INDEX ON :trimet_stop_event (direction);
CREATE INDEX ON :trimet_stop_event (arrive_time);
CREATE INDEX ON :trimet_stop_event (location_id);

\echo adding primary key
ALTER TABLE :trimet_stop_event ADD PRIMARY KEY (date_stamp, vehicle_number, arrive_time);
