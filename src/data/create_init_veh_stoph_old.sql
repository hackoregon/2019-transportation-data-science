\echo setting search path
CREATE SCHEMA IF NOT EXISTS old_raw;
SET search_path TO old_raw, public;
\echo creating vehicle stop history raw data
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
