\echo creating bus_all_stops table
SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS bus_all_stops CASCADE;
CREATE TABLE bus_all_stops (
  vehicle_id integer,
  opd_date date not null,
  day_of_week integer,
  year integer,
  month integer,
  day integer,
  act_arr_time timestamp with time zone, 
  act_dep_time timestamp with time zone, 
  nom_arr_time timestamp with time zone, 
  nom_dep_time timestamp with time zone, 
  event_no_trip integer,
  line_id integer,
  pattern_direction character,
  meters integer,
  stop_id integer,
  stop_pos integer,
  distance_to_next integer,
  distance_to_trip integer,
  doors_opening integer,
  stop_type integer,
  door_open_time integer,
  gps_longitude double precision,
  gps_latitude double precision,
  id serial
) PARTITION BY RANGE(opd_date) ;
CREATE INDEX ON bus_all_stops (opd_date);
ALTER TABLE bus_all_stops ADD PRIMARY KEY (opd_date, id);

\echo creating passenger_stops table
DROP TABLE IF EXISTS passenger_stops CASCADE;
CREATE TABLE passenger_stops (
  vehicle_id integer,
  train integer,
  trip_number integer,
  service_date date not null,
  service_key text,
  arrive_time timestamp with time zone,
  leave_time timestamp with time zone,
  stop_time timestamp with time zone, 
  route_number integer,
  direction integer,
  location_id integer,
  dwell integer,
  door integer,
  lift integer,
  ons integer,
  offs integer,
  estimated_load integer,
  train_mileage double precision,
  x_coordinate double precision.
  y_coordinate double precision,
  id serial
) PARTITION BY RANGE(service_date);
CREATE INDEX ON passenger_stops (service_date);
ALTER TABLE passenger_stops ADD PRIMARY KEY (service_date, id);
