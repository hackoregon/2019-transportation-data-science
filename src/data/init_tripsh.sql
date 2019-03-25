\echo creating trips history
SET search_path TO schema, public;
DROP TABLE IF EXISTS init_tripsh;
CREATE TABLE init_tripsh
(
  opd_date date,
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
COPY init_tripsh FROM :init_tripsh_csv WITH csv header;
