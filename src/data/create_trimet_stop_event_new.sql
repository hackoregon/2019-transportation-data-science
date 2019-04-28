\echo setting search path
CREATE SCHEMA IF NOT EXISTS new_raw;
SET search_path TO new_raw, public;
\echo creating trimet stop event raw data
DROP TABLE IF EXISTS trimet_stop_event;
CREATE TABLE trimet_stop_event
(
  service_date text,
  vehicle_number integer,
  leave_time integer,
  train integer,
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
\echo loading CSV files
COPY trimet_stop_event FROM '1 stopevent July 2018 to Dec 2018.csv' WITH csv header;
