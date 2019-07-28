\echo setting time zone
SET timezone = 'PST8PDT';

\echo creating passenger_stops table
DROP TABLE IF EXISTS passenger_stops CASCADE;
CREATE TABLE passenger_stops (
  service_date date not null,
  vehicle_number integer,
  leave_time timestamp with time zone,
  train integer,
  route_number integer,
  direction integer,
  service_key text,
  trip_number integer,
  stop_time timestamp with time zone, 
  arrive_time timestamp with time zone,
  dwell integer,
  location_id integer,
  door integer,
  lift integer,
  ons integer,
  offs integer,
  estimated_load integer,
  train_mileage double precision,
  x_coordinate double precision,
  y_coordinate double precision,
  year integer,
  month integer,
  day integer,
  day_of_week integer,
  arrive_quarter_hour double precision
) PARTITION BY RANGE(service_date);
CREATE INDEX ON passenger_stops (service_date);

\echo creating trips_history table
DROP TABLE IF EXISTS trips_history CASCADE;
CREATE TABLE trips_history (
  opd_date text,
  vehicle_id integer,
  event_no integer,
  meters integer,
  act_dep_time timestamp with time zone,
  nom_dep_time timestamp with time zone,
  nom_end_time timestamp with time zone,
  act_end_time timestamp with time zone,
  line_id integer,
  pattern_direction text
) PARTITION BY RANGE(opd_date);
CREATE INDEX ON trips_history (opd_date);

\echo creating bus_all_stops table
DROP TABLE IF EXISTS bus_all_stops CASCADE;
CREATE TABLE bus_all_stops (
  event_no_trip integer,
  opd_date date not null,
  vehicle_id integer,
  meters integer,
  act_arr_time timestamp with time zone, 
  act_dep_time timestamp with time zone, 
  nom_arr_time timestamp with time zone, 
  nom_dep_time timestamp with time zone, 
  stop_id integer,
  stop_pos integer,
  distance_to_next integer,
  distance_to_trip integer,
  doors_opening integer,
  stop_type integer,
  gps_longitude double precision,
  gps_latitude double precision,
  door_open_time integer,
  line_id integer,
  pattern_direction character,
  year integer,
  month integer,
  day integer,
  day_of_week integer,
  arrive_quarter_hour double precision
) PARTITION BY RANGE(opd_date) ;
CREATE INDEX ON bus_all_stops (opd_date);

\echo creating disturbance_stops table
SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS disturbance_stops CASCADE;
CREATE TABLE disturbance_stops (
  opd_date date not null,
  service_key text,
  year integer,
  month integer,
  day integer,
  day_of_week integer,
  act_arr_time timestamp with time zone,
  act_dep_time timestamp with time zone,
  start_quarter_hour real,
  end_quarter_hour real,
  duration interval,
  line_id integer,
  pattern_direction text,
  longitude double precision,
  latitude double precision
) PARTITION BY RANGE(opd_date) ;
CREATE INDEX ON disturbance_stops (opd_date);
