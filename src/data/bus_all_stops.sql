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
  geom_point_4326 geometry(POINT, 4326),
  id serial
) PARTITION BY RANGE(opd_date) ;

CREATE TABLE bus_all_stops_y2017m09
PARTITION OF bus_all_stops
FOR VALUES FROM ('2017-09-01') TO ('2017-10-01');

CREATE TABLE bus_all_stops_y2017m10
PARTITION OF bus_all_stops
FOR VALUES FROM ('2017-10-01') TO ('2017-11-01');

CREATE TABLE bus_all_stops_y2017m11
PARTITION OF bus_all_stops
FOR VALUES FROM ('2017-11-01') TO ('2017-12-01');

CREATE TABLE bus_all_stops_y2018m04
PARTITION OF bus_all_stops
FOR VALUES FROM ('2018-04-01') TO ('2018-05-01');

CREATE TABLE bus_all_stops_y2018m05
PARTITION OF bus_all_stops
FOR VALUES FROM ('2018-05-01') TO ('2018-06-01');

CREATE TABLE bus_all_stops_y2018m07
PARTITION OF bus_all_stops
FOR VALUES FROM ('2018-07-01') TO ('2018-08-01');

CREATE TABLE bus_all_stops_y2018m08
PARTITION OF bus_all_stops
FOR VALUES FROM ('2018-08-01') TO ('2018-09-01');

CREATE TABLE bus_all_stops_y2018m09
PARTITION OF bus_all_stops
FOR VALUES FROM ('2018-09-01') TO ('2018-10-01');

CREATE TABLE bus_all_stops_y2018m10
PARTITION OF bus_all_stops
FOR VALUES FROM ('2018-10-01') TO ('2018-11-01');

CREATE TABLE bus_all_stops_y2018m11
PARTITION OF bus_all_stops
FOR VALUES FROM ('2018-11-01') TO ('2018-12-01');

CREATE TABLE bus_all_stops_y2019m04
PARTITION OF bus_all_stops
FOR VALUES FROM ('2019-04-01') TO ('2019-05-01');

CREATE TABLE bus_all_stops_y2019m05
PARTITION OF bus_all_stops
FOR VALUES FROM ('2019-05-01') TO ('2019-06-01');

CREATE TABLE bus_all_stops_y2019m06
PARTITION OF bus_all_stops
FOR VALUES FROM ('2019-06-01') TO ('2019-07-01');

CREATE TABLE bus_all_stops_y2019m07
PARTITION OF bus_all_stops
FOR VALUES FROM ('2019-07-01') TO ('2019-08-01');

CREATE INDEX ON bus_all_stops (opd_date);

\echo loading
INSERT INTO bus_all_stops
SELECT raw.raw_veh_stoph.vehicle_id, raw.raw_veh_stoph.date_stamp::date AS opd_date,
  date_part('dow', raw.raw_veh_stoph.date_stamp) AS day_of_week,
  date_part('year', raw.raw_veh_stoph.date_stamp) AS year,
  date_part('month', raw.raw_veh_stoph.date_stamp) AS month,
  date_part('day', raw.raw_veh_stoph.date_stamp) AS day,
  raw.raw_veh_stoph.date_stamp + raw.raw_veh_stoph.act_arr_time * interval '1 sec' AS act_arr_time, 
  raw.raw_veh_stoph.date_stamp + raw.raw_veh_stoph.act_dep_time * interval '1 sec' AS act_dep_time, 
  raw.raw_veh_stoph.date_stamp + raw.raw_veh_stoph.nom_arr_time * interval '1 sec' AS nom_arr_time, 
  raw.raw_veh_stoph.date_stamp + raw.raw_veh_stoph.nom_dep_time * interval '1 sec' AS nom_dep_time, 
  raw.raw_veh_stoph.event_no_trip, bus_trips.line_id, bus_trips.pattern_direction,
  raw.raw_veh_stoph.meters, stop_id, stop_pos, distance_to_next, distance_to_trip,
  doors_opening, stop_type, door_open_time,
  gps_longitude, gps_latitude,
  ST_SetSRID(ST_MakePoint(gps_longitude, gps_latitude), 4326) AS geom_point_4326
FROM raw.raw_veh_stoph
INNER JOIN bus_trips ON bus_trips.event_no_trip = raw.raw_veh_stoph.event_no_trip
WHERE stop_type = 3;
\echo primary key
ALTER TABLE bus_all_stops ADD PRIMARY KEY (event_no_trip, opd_date, id);
\echo truncating input table
TRUNCATE TABLE raw.raw_veh_stoph;
