\echo deleting unwanted rows
\echo weekday service key is W for buses and A for MAX!
SET search_path TO :schema, public;
DELETE FROM trimet_stop_event
  WHERE service_key IS NULL 
  OR NOT (service_key = 'W' OR service_key = 'A')
  OR route_number IS NULL
  OR route_number > 291
  OR route_number < 1
;

\echo indexing the variables that define events
CREATE INDEX ON trimet_stop_event (service_date);
CREATE INDEX ON trimet_stop_event (vehicle_number);
CREATE INDEX ON trimet_stop_event (leave_time);
CREATE INDEX ON trimet_stop_event (route_number);
CREATE INDEX ON trimet_stop_event (direction);
CREATE INDEX ON trimet_stop_event (arrive_time);
CREATE INDEX ON trimet_stop_event (location_id);
