DROP TABLE IF EXISTS ENDDATE_init_cyclic_v1h;
CREATE TABLE ENDDATE_init_cyclic_v1h (
  event_no_trip integer,
  event_no_stop integer,
  opd_date_text text,
  vehicle_id integer,
  meters integer,
  act_time integer,
  gps_longitude double precision,
  gps_latitude double precision,
  gps_satellites integer,
  gps_hdop double precision
);
