\echo loading old format raw data
\echo setting search path
CREATE SCHEMA IF NOT EXISTS old_raw;
SET search_path TO old_raw, public;
\echo creating trips history old raw data
DROP TABLE IF EXISTS init_tripsh;
CREATE TABLE init_tripsh
(
  opd_date text,
  vehicle_id integer,
  master_id integer,
  event_no integer,
  event_no_course integer,
  meters integer,
  act_dep_time integer,
  nom_dep_time integer,
  nom_end_time integer,
  act_end_time integer,
  line_id integer,
  course_id integer,
  trip_id integer,
  pattern_id integer,
  pattern_direction text,
  trip_type integer,
  highway_type integer,
  pattern_quality integer,
  block_id integer,
  passenger_data integer,
  time_grp_id integer,
  trip_code integer,
  driver_id integer,
  data_source integer,
  is_additional_trip integer,
  trip_role text,
  trip_subrole text,
  trip_purpose integer
);
\echo loading CSV files
COPY init_tripsh FROM '/csvs/init_tripsh 1-30SEP2017.csv' WITH csv header;
COPY init_tripsh FROM '/csvs/init_tripsh 1-31OCT2017.csv' WITH csv header;
COPY init_tripsh FROM '/csvs/init_tripsh 1-30NOV2017.csv' WITH csv header;
COPY init_tripsh FROM '/csvs/init_tripsh 1-30APR2018.csv' WITH csv header;
COPY init_tripsh FROM '/csvs/init_tripsh 1-31MAY2018.csv' WITH csv header;

\echo
\echo creating vehicle stop history old raw data
DROP TABLE IF EXISTS init_veh_stoph;
CREATE TABLE init_veh_stoph
(
  event_no integer,
  event_no_trip integer,
  event_no_prev integer,
  opd_date text,
  vehicle_id integer,
  master_id text,
  meters integer,
  act_arr_time integer,
  act_dep_time integer,
  nom_arr_time integer,
  nom_dep_time integer,
  point_id integer,
  stop_id integer,
  stop_pos integer,
  distance_to_next integer,
  distance_to_trip integer,
  doors_opening integer,
  positioning_method integer,
  stop_type integer,
  gps_longitude double precision,
  gps_latitude double precision,
  pattern_idx integer,
  door_open_time integer,
  point_role text,
  point_action text,
  plan_status text
);
\echo loading CSV files
COPY init_veh_stoph FROM '/csvs/init_veh_stoph 1-30SEP2017.csv' WITH csv header;
COPY init_veh_stoph FROM '/csvs/init_veh_stoph 1-31OCT2017.csv' WITH csv header;
COPY init_veh_stoph FROM '/csvs/init_veh_stoph 1-30NOV2017.csv' WITH csv header;
COPY init_veh_stoph FROM '/csvs/init_veh_stoph 1-30APR2018.csv' WITH csv header;
COPY init_veh_stoph FROM '/csvs/init_veh_stoph 1-31MAY2018.csv' WITH csv header;

\echo
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

\echo
\echo loading new format raw data
\echo setting search path
CREATE SCHEMA IF NOT EXISTS new_raw;
SET search_path TO new_raw, public;
\echo creating trips history new raw data
DROP TABLE IF EXISTS init_tripsh;
CREATE TABLE init_tripsh
(
  opd_date text,
  vehicle_id integer,
  event_no integer,
  event_no_course integer,
  meters integer,
  act_dep_time integer,
  nom_dep_time integer,
  nom_end_time integer,
  act_end_time integer,
  line_id integer,
  course_id integer,
  trip_id integer,
  pattern_id integer,
  pattern_direction text,
  trip_type integer,
  highway_type integer,
  pattern_quality integer,
  block_id integer,
  time_grp_id integer,
  trip_code integer,
  data_source integer,
  is_additional_trip integer,
  trip_role text,
  trip_subrole text,
  trip_purpose integer
);
\echo loading CSV files
COPY init_tripsh FROM '/csvs/1 init_tripsh July 2018 to Dec 2018.csv' WITH csv header;

\echo
\echo creating vehicle stop history new raw data
DROP TABLE IF EXISTS init_veh_stoph;
CREATE TABLE init_veh_stoph
(
  event_no integer,
  event_no_trip integer,
  event_no_prev integer,
  opd_date text,
  vehicle_id integer,
  meters integer,
  act_arr_time integer,
  act_dep_time integer,
  nom_arr_time integer,
  nom_dep_time integer,
  point_id integer,
  stop_id integer,
  stop_pos integer,
  distance_to_next integer,
  distance_to_trip integer,
  doors_opening integer,
  positioning_method integer,
  stop_type integer,
  gps_longitude double precision,
  gps_latitude double precision,
  pattern_idx integer,
  door_open_time integer,
  point_role text,
  point_action text,
  plan_status text
);
\echo loading CSV files
COPY init_veh_stoph FROM '/csvs/1 init_veh_stoph July 2018 to Dec 2018.csv' WITH csv header;

\echo
\echo creating trimet stop event new raw data
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
COPY trimet_stop_event FROM '/csvs/1 stopevent July 2018 to Dec 2018.csv' WITH csv header;
