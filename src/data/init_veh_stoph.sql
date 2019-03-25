\echo creating vehicle stop history
SET search_path TO :schema, public;
DROP TABLE IF EXISTS init_veh_stoph;
CREATE TABLE init_veh_stoph
(
  event_no integer,
  event_no_trip integer,
  event_no_prev integer,
  opd_date date,
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
COPY init_veh_stoph FROM :csvfile WITH csv header;
\echo
\echo deleting unwanted rows
DELETE FROM init_veh_stoph
  WHERE opd_date NOT IN (SELECT service_date FROM weekdays)
;
\echo
\echo indexing
CREATE INDEX ON init_veh_stoph (opd_date);
CREATE INDEX ON init_veh_stoph (vehicle_id);
CREATE INDEX ON init_veh_stoph (event_no_trip);
CREATE INDEX ON init_veh_stoph (act_arr_time);
CREATE INDEX ON init_veh_stoph (act_dep_time);
CREATE INDEX ON init_veh_stoph (nom_arr_time);
CREATE INDEX ON init_veh_stoph (nom_dep_time);
CREATE INDEX ON init_veh_stoph (point_id);
\echo
\echo primary key
ALTER TABLE init_veh_stoph ADD COLUMN pkey serial;
ALTER TABLE init_veh_stoph ADD PRIMARY KEY (pkey);
