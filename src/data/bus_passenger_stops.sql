SET timezone = 'PST8PDT';

--\echo creating bus_passenger_stops table
DROP TABLE IF EXISTS bus_passenger_stops CASCADE;
CREATE TABLE bus_passenger_stops (
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
  geom_point_4326 geometry(POINT, 4326),
  longitude double precision,
  latitude double precision,
  year integer,
  month integer,
  day integer,
  day_of_week integer,
  seconds_late integer,
  arriving_load integer,
  arrive_quarter_hour double precision,
  previous_location_id integer,
  previous_arrive_time timestamp with time zone,
  previous_train_mileage double precision,
  id serial
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

CREATE TABLE bus_passenger_stops_y2018m04
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2018-04-01') TO ('2018-05-01');

CREATE TABLE bus_passenger_stops_y2018m05
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2018-05-01') TO ('2018-06-01');

CREATE TABLE bus_passenger_stops_y2018m07
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2018-07-01') TO ('2018-08-01');

CREATE TABLE bus_passenger_stops_y2018m08
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2018-08-01') TO ('2018-09-01');

CREATE TABLE bus_passenger_stops_y2018m09
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2018-09-01') TO ('2018-10-01');

CREATE TABLE bus_passenger_stops_y2018m10
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2018-10-01') TO ('2018-11-01');

CREATE TABLE bus_passenger_stops_y2018m11
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2018-11-01') TO ('2018-12-01');

CREATE TABLE bus_passenger_stops_y2019m04
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2019-04-01') TO ('2019-05-01');

CREATE TABLE bus_passenger_stops_y2019m05
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2019-05-01') TO ('2019-06-01');

CREATE TABLE bus_passenger_stops_y2019m06
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2019-06-01') TO ('2019-07-01');

CREATE TABLE bus_passenger_stops_y2019m07
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2019-07-01') TO ('2019-08-01');

CREATE TABLE bus_passenger_stops_y2019m08
PARTITION OF bus_passenger_stops
FOR VALUES FROM ('2019-08-01') TO ('2019-09-01');

CREATE INDEX ON bus_passenger_stops (service_date);

--\echo loading
INSERT INTO bus_passenger_stops
SELECT vehicle_number AS vehicle_id, train, trip_number,
  date_stamp::date AS service_date, service_key,
  date_stamp + arrive_time * interval '1 sec' AS arrive_time, 
  date_stamp + leave_time * interval '1 sec' AS leave_time, 
  date_stamp + stop_time * interval '1 sec' AS stop_time, 
  route_number, direction, location_id, dwell, door, lift, ons, offs, estimated_load, train_mileage,
  ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326) AS geom_point_4326,
  ST_X(ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326)) AS longitude,
  ST_Y(ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326)) AS latitude,
  date_part('year', date_stamp) AS year,
  date_part('month', date_stamp) AS month,
  date_part('day', date_stamp) AS day,
  date_part('dow', date_stamp) AS day_of_week,
  greatest(0, arrive_time - stop_time) AS seconds_late,
  estimated_load - ons + offs AS arriving_load,
  0.25*trunc(
    4*date_part('hour', (date_stamp + arrive_time * interval '1 sec') AT TIME ZONE 'America/Los_Angeles') +
    date_part('minute', (date_stamp + arrive_time * interval '1 sec') AT TIME ZONE 'America/Los_Angeles')/15
  ) AS arrive_quarter_hour,
  LAG(location_id) OVER (
    PARTITION BY vehicle_number, train, trip_number, service_date, route_number, direction
    ORDER BY arrive_time
  ) AS previous_location_id,
  date_stamp + (LAG(arrive_time) OVER (
    PARTITION BY vehicle_number, train, trip_number, service_date, route_number, direction
    ORDER BY arrive_time
  )) * interval '1 sec' AS previous_arrive_time,
  LAG(train_mileage) OVER (
    PARTITION BY vehicle_number, train, trip_number, service_date, route_number, direction
    ORDER BY arrive_time
  ) AS previous_train_mileage
FROM raw.raw_stop_event
WHERE route_number IS NOT NULL
AND route_number <= 291
AND route_number >= 1
AND route_number NOT IN (SELECT rte FROM rail_routes)
AND vehicle_number > 0
AND trip_number > 0
AND location_id > 0
AND service_key IS NOT NULL
ORDER BY service_date, vehicle_id, arrive_time;

--\echo truncating input table
TRUNCATE TABLE raw.raw_stop_event;

--\echo primary key
ALTER TABLE bus_passenger_stops 
ADD PRIMARY KEY (service_date, id);

--\echo bus service keys
DROP TABLE IF EXISTS bus_service_keys;
CREATE TABLE bus_service_keys AS
SELECT DISTINCT service_date, service_key
FROM bus_passenger_stops
ORDER BY service_date;
ALTER TABLE bus_service_keys ADD PRIMARY KEY (service_date, service_key);
