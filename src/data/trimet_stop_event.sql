\echo schema :schema
\echo creating trimet stop event
DROP SCHEMA IF EXISTS :schema CASCADE;
CREATE SCHEMA :schema;
SET search_path TO :schema, public;
DROP TABLE IF EXISTS trimet_stop_event;
CREATE TABLE trimet_stop_event
(
  service_date date,
  vehicle_number integer,
  leave_time integer,
  train integer,
  badge integer,
  route_number integer,
  direction integer,
  service_key text,
  trip_number integer,
  stop_time integer,
  arrive_time integer,
  dwell integer,
  location_id integer,
  door integer,
  lift integer,
  ons integer,
  offs integer,
  estimated_load integer,
  maximum_speed integer,
  train_mileage double precision,
  pattern_distance double precision,
  location_distance double precision,
  x_coordinate double precision,
  y_coordinate double precision,
  data_source integer,
  schedule_status integer
);
COPY trimet_stop_event FROM :csvfile WITH csv header;
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
CREATE INDEX ON trimet_stop_event (service_date);
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
\echo computing weekday list for filtering disturbance stops
CREATE TABLE weekdays AS
SELECT DISTINCT service_date FROM trimet_stop_event
ORDER BY service_date;
CREATE INDEX ON weekdays (service_date);
