DELETE FROM trimet_stop_event
  WHERE service_key IS NULL 
  OR route_number IS NULL
  OR service_key != 'W'
  OR route_number > 291
  OR route_number < 1
;
ALTER TABLE trimet_stop_event DROP COLUMN IF EXISTS badge;
ALTER TABLE trimet_stop_event DROP COLUMN IF EXISTS maximum_speed;
ALTER TABLE trimet_stop_event DROP COLUMN IF EXISTS pattern_distance;
ALTER TABLE trimet_stop_event DROP COLUMN IF EXISTS location_distance;
ALTER TABLE trimet_stop_event DROP COLUMN IF EXISTS data_source;
ALTER TABLE trimet_stop_event DROP COLUMN IF EXISTS schedule_status;
CREATE INDEX ON trimet_stop_event (date_stamp);
CREATE INDEX ON trimet_stop_event (vehicle_number);
CREATE INDEX ON trimet_stop_event (arrive_time);
