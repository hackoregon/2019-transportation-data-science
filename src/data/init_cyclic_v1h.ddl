DROP TABLE IF EXISTS ENDDATE_init_cyclic_v1h;
CREATE TABLE ENDDATE_init_cyclic_v1h (
  opd_date timestamp,
  vehicle_id text,
  block_code text,
  event_no_trip integer,
  event_no_stop integer,
  meters integer,
  act_time integer,
  gps_latitude double precision,
  gps_longitude double precision
);
