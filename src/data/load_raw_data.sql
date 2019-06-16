\echo setting search path and timezone
CREATE SCHEMA IF NOT EXISTS raw;
SET search_path TO raw, public;
SET timezone = 'PST8PDT';
\echo creating tables
DROP TABLE IF EXISTS raw_veh_stoph CASCADE;
CREATE TABLE raw_veh_stoph (
  event_no_trip integer,
  opd_date text,
  vehicle_id integer,
  meters integer,
  act_arr_time integer,
  act_dep_time integer,
  nom_arr_time integer,
  nom_dep_time integer,
  stop_id integer,
  distance_to_next integer,
  distance_to_trip integer,
  doors_opening integer,
  stop_type integer,
  gps_longitude double precision,
  gps_latitude double precision,
  door_open_time integer
);
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
DROP TABLE IF EXISTS raw_tripsh CASCADE;
CREATE TABLE raw_tripsh (
  opd_date text,
  vehicle_id integer,
  event_no integer,
  meters integer,
  act_dep_time integer,
  nom_dep_time integer,
  nom_end_time integer,
  act_end_time integer,
  line_id integer,
  pattern_direction text
);
\echo loading raw_veh_stoph
COPY raw_veh_stoph FROM '/csvs/raw_veh_stoph_2017_09.csv' WITH csv header;
COPY raw_veh_stoph FROM '/csvs/raw_veh_stoph_2017_10.csv' WITH csv header;
COPY raw_veh_stoph FROM '/csvs/raw_veh_stoph_2017_11.csv' WITH csv header;
COPY raw_veh_stoph FROM '/csvs/raw_veh_stoph_2018_09.csv' WITH csv header;
COPY raw_veh_stoph FROM '/csvs/raw_veh_stoph_2018_10.csv' WITH csv header;
COPY raw_veh_stoph FROM '/csvs/raw_veh_stoph_2018_11.csv' WITH csv header;
\echo indexing raw_veh_stoph
CREATE INDEX ON raw_veh_stoph (event_no_trip);

\echo loading raw_stop_event
COPY raw_stop_event FROM '/csvs/raw_stop_event_2017_09.csv' WITH csv header;
COPY raw_stop_event FROM '/csvs/raw_stop_event_2017_10.csv' WITH csv header;
COPY raw_stop_event FROM '/csvs/raw_stop_event_2017_11.csv' WITH csv header;
COPY raw_stop_event FROM '/csvs/raw_stop_event_2018_09.csv' WITH csv header;
COPY raw_stop_event FROM '/csvs/raw_stop_event_2018_10.csv' WITH csv header;
COPY raw_stop_event FROM '/csvs/raw_stop_event_2018_11.csv' WITH csv header;

\echo loading raw_tripsh
COPY raw_tripsh FROM '/csvs/raw_tripsh_2017_09.csv' WITH csv header;
COPY raw_tripsh FROM '/csvs/raw_tripsh_2017_10.csv' WITH csv header;
COPY raw_tripsh FROM '/csvs/raw_tripsh_2017_11.csv' WITH csv header;
COPY raw_tripsh FROM '/csvs/raw_tripsh_2018_09.csv' WITH csv header;
COPY raw_tripsh FROM '/csvs/raw_tripsh_2018_10.csv' WITH csv header;
COPY raw_tripsh FROM '/csvs/raw_tripsh_2018_11.csv' WITH csv header;

\echo date stamps on raw_veh_stoph
ALTER TABLE raw_veh_stoph ADD COLUMN date_stamp timestamp with time zone;
UPDATE raw_veh_stoph SET date_stamp = to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS');

\echo date stamps on raw_stop_event
ALTER TABLE raw_stop_event ADD COLUMN date_stamp timestamp with time zone;
UPDATE raw_stop_event SET date_stamp = to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS');

\echo date stamps on raw_tripsh
ALTER TABLE raw_tripsh ADD COLUMN date_stamp timestamp with time zone;
UPDATE raw_tripsh SET date_stamp = to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS');
