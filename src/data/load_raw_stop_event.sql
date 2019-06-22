\echo setting search path and timezone
SET search_path TO raw, public;
SET timezone = 'PST8PDT';

\echo creating tables
DROP TABLE IF EXISTS raw_stop_event CASCADE;
CREATE TABLE raw_stop_event (
  service_date text,
  vehicle_number integer,
  leave_time integer,
  route_number integer,
  direction integer,
  service_key text,
  stop_time integer,
  arrive_time integer,
  dwell integer,
  location_id integer,
  door integer,
  lift integer,
  ons integer,
  offs integer,
  estimated_load integer,
  train_mileage double precision,
  x_coordinate double precision,
  y_coordinate double precision
);

\echo loading raw_stop_event
COPY raw_stop_event FROM '/csvs/raw_stop_event_2017_09.csv' WITH csv header;
COPY raw_stop_event FROM '/csvs/raw_stop_event_2017_10.csv' WITH csv header;
COPY raw_stop_event FROM '/csvs/raw_stop_event_2017_11.csv' WITH csv header;
COPY raw_stop_event FROM '/csvs/raw_stop_event_2018_09.csv' WITH csv header;
COPY raw_stop_event FROM '/csvs/raw_stop_event_2018_10.csv' WITH csv header;
COPY raw_stop_event FROM '/csvs/raw_stop_event_2018_11.csv' WITH csv header;

\echo date stamps on raw_stop_event
ALTER TABLE raw_stop_event ADD COLUMN date_stamp timestamp with time zone;
UPDATE raw_stop_event SET date_stamp = to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS');
