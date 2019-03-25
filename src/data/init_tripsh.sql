\echo schema :schema
\echo creating trips history
SET search_path TO :schema, public;
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
COPY init_tripsh FROM :csvfile WITH csv header;
\echo
\echo deleting unwanted rows
DELETE FROM init_tripsh
  WHERE opd_date NOT IN (SELECT service_date FROM weekdays)
  OR line_id IS NULL
  OR line_id > 291
  OR line_id < 1
;
\echo
\echo indexing
CREATE INDEX ON init_tripsh (opd_date);
CREATE INDEX ON init_tripsh (vehicle_id);
CREATE INDEX ON init_tripsh (event_no);
CREATE INDEX ON init_tripsh (line_id);
\echo
\echo primary key
ALTER TABLE init_tripsh ADD COLUMN pkey serial;
ALTER TABLE init_tripsh ADD PRIMARY KEY (pkey);
