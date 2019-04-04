\echo parsing dates
SET timezone = 'PST8PDT';
ALTER TABLE trimet_stop_event ADD COLUMN date_stamp timestamp with time zone;
UPDATE trimet_stop_event SET date_stamp = to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS');
\echo
\echo deleting unwanted rows
\echo weekday service key is W for buses and A for MAX!
DELETE FROM trimet_stop_event
  WHERE service_key IS NULL 
  OR NOT (service_key = 'W' OR service_key = 'A')
  OR route_number IS NULL
  OR route_number > 291
  OR route_number < 1
;
\echo
\echo indexing
CREATE INDEX ON trimet_stop_event (date_stamp);
CREATE INDEX ON trimet_stop_event (vehicle_number);
CREATE INDEX ON trimet_stop_event (leave_time);
CREATE INDEX ON trimet_stop_event (route_number);
CREATE INDEX ON trimet_stop_event (direction);
CREATE INDEX ON trimet_stop_event (stop_time);
CREATE INDEX ON trimet_stop_event (arrive_time);
CREATE INDEX ON trimet_stop_event (location_id);
\echo
\echo primary key
ALTER TABLE trimet_stop_event ADD COLUMN pkey serial;
ALTER TABLE trimet_stop_event ADD PRIMARY KEY (pkey);
\echo
\echo vacuuming
VACUUM ANALYZE trimet_stop_event;
\echo
\echo computing weekday list for filtering disturbance stops
CREATE TABLE weekdays AS
SELECT DISTINCT date_stamp FROM trimet_stop_event
ORDER BY date_stamp;
CREATE INDEX ON weekdays (date_stamp);
ALTER TABLE weekdays ADD PRIMARY KEY (date_stamp);
