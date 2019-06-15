-- there are no entries for MAX in the other tables, just buses
-- so we have separate bus and rail passenger stop tables
SET timezone = 'PST8PDT';

\echo creating bus_passenger_stops table
DROP TABLE IF EXISTS bus_passenger_stops CASCADE;
CREATE TABLE bus_passenger_stops (
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
  x_coordinate double precision,
  y_coordinate double precision
) PARTITION BY RANGE(service_date);

CREATE TABLE bus_passenger_stops_y2017m09
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2017-09-01') TO ('2017-10-01');

CREATE TABLE bus_passenger_stops_y2017m10
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2017-10-01') TO ('2017-11-01');

CREATE TABLE bus_passenger_stops_y2017m11
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2017-11-01') TO ('2017-12-01');

CREATE TABLE bus_passenger_stops_y2018m09
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2018-09-01') TO ('2018-10-01');

CREATE TABLE bus_passenger_stops_y2018m10
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2018-10-01') TO ('2018-11-01');

CREATE TABLE bus_passenger_stops_y2018m11
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2018-11-01') TO ('2018-12-01');

CREATE INDEX ON bus_passenger_stops (service_date);

\echo loading
INSERT INTO bus_passenger_stops
SELECT vehicle_number AS vehicle_id, date_stamp::date AS service_date, service_key,
  date_stamp + arrive_time * interval '1 sec' AS arrive_time, 
  date_stamp + leave_time * interval '1 sec' AS leave_time, 
  date_stamp + stop_time * interval '1 sec' AS stop_time, 
  route_number, direction, location_id, dwell, door, lift, ons, offs, estimated_load,
  train_mileage, x_coordinate, y_coordinate
FROM raw.raw_stop_event
WHERE (service_key = 'W' OR service_key = 'S' OR service_key = 'U' OR service_key = 'X')
AND route_number IS NOT NULL
AND route_number <= 291
AND route_number >= 1
AND route_number IN (SELECT DISTINCT line_id FROM bus_trips);

\echo primary key
ALTER TABLE bus_passenger_stops 
ADD PRIMARY KEY (vehicle_id, service_date, arrive_time, leave_time);

\echo bus service keys
CREATE TABLE bus_service_keys AS
SELECT DISTINCT service_date, service_key
FROM bus_passenger_stops
ORDER BY service_date;
ALTER TABLE bus_service_keys ADD PRIMARY KEY (service_date);
