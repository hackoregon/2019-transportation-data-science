\echo setting time zone
SET timezone = 'PST8PDT';

\echo creating tables for raw data loading
DROP TABLE IF EXISTS raw_stop_event;
CREATE TABLE raw_stop_event (
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
  train_mileage double precision,
  x_coordinate double precision,
  y_coordinate double precision

DROP TABLE IF EXISTS raw_tripsh;
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

DROP TABLE IF EXISTS raw_veh_stoph;
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
  stop_pos integer,
  distance_to_next integer,
  distance_to_trip integer,
  doors_opening integer,
  stop_type integer,
  gps_longitude double precision,
  gps_latitude double precision,
  door_open_time integer

\echo creating bus_all_stops table
DROP TABLE IF EXISTS bus_all_stops CASCADE;
CREATE TABLE bus_all_stops (
  vehicle_id integer,
  opd_date date not null,
  day_of_week integer,
  year integer,
  month integer,
  day integer,
  act_arr_time timestamp with time zone, 
  act_dep_time timestamp with time zone, 
  nom_arr_time timestamp with time zone, 
  nom_dep_time timestamp with time zone, 
  event_no_trip integer,
  line_id integer,
  pattern_direction character,
  meters integer,
  stop_id integer,
  stop_pos integer,
  distance_to_next integer,
  distance_to_trip integer,
  doors_opening integer,
  stop_type integer,
  door_open_time integer,
  gps_longitude double precision,
  gps_latitude double precision,
  id serial
) PARTITION BY RANGE(opd_date) ;
CREATE INDEX ON bus_all_stops (opd_date);
ALTER TABLE bus_all_stops ADD PRIMARY KEY (opd_date, id);

\echo creating passenger_stops table
DROP TABLE IF EXISTS passenger_stops CASCADE;
CREATE TABLE passenger_stops (
  vehicle_id integer,
  train integer,
  trip_number integer,
  service_date date not null,
  service_key text,
  arrive_time timestamp with time zone,
  leave_time timestamp with time zone,
  stop_time timestamp with time zone, 
  route_number integer,
  direction integer,
  location_id integer,
  dwell integer,
  door integer,
  lift integer,
  ons integer,
  offs integer,
  estimated_load integer,
  train_mileage double precision,
  x_coordinate double precision.
  y_coordinate double precision,
  id serial
) PARTITION BY RANGE(service_date);
CREATE INDEX ON passenger_stops (service_date);
ALTER TABLE passenger_stops ADD PRIMARY KEY (service_date, id);
