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
