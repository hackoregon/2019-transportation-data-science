\echo setting search path
CREATE SCHEMA IF NOT EXISTS old_raw;
SET search_path TO old_raw, public;
\echo creating trimet stop event old raw data
DROP TABLE IF EXISTS trimet_stop_event;
CREATE TABLE trimet_stop_event
(
  service_date text,
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
\echo loading CSV files
COPY trimet_stop_event FROM '/csvs/trimet_stop_event 1-30SEP2017.csv' WITH csv header;
COPY trimet_stop_event FROM '/csvs/trimet_stop_event 1-31OCT2017.csv' WITH csv header;
COPY trimet_stop_event FROM '/csvs/trimet_stop_event 1-30NOV2017.csv' WITH csv header;
COPY trimet_stop_event FROM '/csvs/trimet_stop_event 1-30APR2018.csv' WITH csv header;
COPY trimet_stop_event FROM '/csvs/trimet_stop_event 1-31MAY2018.csv' WITH csv header;
