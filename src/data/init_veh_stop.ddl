DROP TABLE IF EXISTS ENDDATE_init_veh_stop;
CREATE TABLE ENDDATE_init_veh_stop (
  opd_date timestamp,
  vehicle_id text,
  block_code text,
  event_no_stop integer,
  meters integer,
  act_arr_time integer,
  act_dep_time integer,
  nom_arr_time integer,
  nom_dep_time integer,
  point_id integer,
  doors_opening integer,
  stop_type integer,
  gps_latitude double precision,
  gps_longitude double precision,
  door_open_time integer
);
