-- there are no entries for MAX in the other tables, just buses
-- so we have separate bus and rail passenger stop tables
SET timezone = 'PST8PDT';

\echo creating rail route table
DROP TABLE IF EXISTS rail_routes;
CREATE TABLE rail_routes AS
SELECT DISTINCT rte FROM trimet_gis.tm_routes 
WHERE type = 'MAX'
ORDER BY rte;

\echo creating rail_passenger_stops table
DROP TABLE IF EXISTS rail_passenger_stops CASCADE;
CREATE TABLE rail_passenger_stops (
  vehicle_id integer,
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
  geom_point_4326 point
) PARTITION BY RANGE(service_date);

CREATE TABLE rail_passenger_stops_y2017m09
PARTITION OF rail_passenger_stops
FOR VALUES FROM ('2017-09-01') TO ('2017-10-01');

CREATE TABLE rail_passenger_stops_y2017m10
PARTITION OF rail_passenger_stops
FOR VALUES FROM ('2017-10-01') TO ('2017-11-01');

CREATE TABLE rail_passenger_stops_y2017m11
PARTITION OF rail_passenger_stops
FOR VALUES FROM ('2017-11-01') TO ('2017-12-01');

CREATE TABLE rail_passenger_stops_y2018m09
PARTITION OF rail_passenger_stops
FOR VALUES FROM ('2018-09-01') TO ('2018-10-01');

CREATE TABLE rail_passenger_stops_y2018m10
PARTITION OF rail_passenger_stops
FOR VALUES FROM ('2018-10-01') TO ('2018-11-01');

CREATE TABLE rail_passenger_stops_y2018m11
PARTITION OF rail_passenger_stops
FOR VALUES FROM ('2018-11-01') TO ('2018-12-01');

CREATE INDEX ON rail_passenger_stops (service_date);

\echo loading
INSERT INTO rail_passenger_stops
SELECT vehicle_number AS vehicle_id, date_stamp::date AS service_date, service_key,
  date_stamp + arrive_time * interval '1 sec' AS arrive_time, 
  date_stamp + leave_time * interval '1 sec' AS leave_time, 
  date_stamp + stop_time * interval '1 sec' AS stop_time, 
  route_number, direction, location_id, dwell, door, lift, ons, offs, estimated_load, train_mileage,
  ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326)::point AS geom_point_4326
FROM raw.raw_stop_event
WHERE (service_key = 'A' OR service_key = 'B' OR service_key = 'C' OR service_key = 'X')
AND route_number IS NOT NULL
AND route_number <= 291
AND route_number >= 1
AND route_number IN (SELECT rte FROM rail_routes);

\echo primary key
ALTER TABLE rail_passenger_stops 
ADD PRIMARY KEY (vehicle_id, service_date, arrive_time, leave_time);

\echo rail service keys
CREATE TABLE rail_service_keys AS
SELECT DISTINCT service_date, service_key
FROM rail_passenger_stops
ORDER BY service_date;
ALTER TABLE rail_service_keys ADD PRIMARY KEY (service_date);
