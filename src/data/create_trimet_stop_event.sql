\echo creating trimet stop event
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
