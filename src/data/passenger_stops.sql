\echo creating passenger_stops table
-- there are no entries for MAX in the other tables, just buses
-- so we can save space by not keeping MAX stop events
SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS passenger_stops;
CREATE TABLE passenger_stops AS
SELECT to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') AS date_stamp, 
  vehicle_number, route_number, direction, location_id, 
  stop_time AS scheduled_arrive_time, arrive_time AS actual_arrive_time,
  leave_time, dwell, door, lift, ons, offs, estimated_load, train_mileage, 
  ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326) AS geom_point_4326
FROM trimet_stop_event
WHERE service_key = 'W'
AND route_number IS NOT NULL
AND route_number <= 291
AND route_number >= 1;
\echo
\echo indexing
CREATE INDEX ON passenger_stops (date_stamp);
CREATE INDEX ON passenger_stops (vehicle_number);
CREATE INDEX ON passenger_stops (route_number, direction);
CREATE INDEX ON passenger_stops (location_id);
CREATE INDEX ON passenger_stops (scheduled_arrive_time);
CREATE INDEX ON passenger_stops (actual_arrive_time);
CREATE INDEX ON passenger_stops (leave_time);
CREATE INDEX ON passenger_stops USING GIST (geom_point_4326);
\echo
\echo primary key
ALTER TABLE passenger_stops ADD PRIMARY KEY (vehicle_number, date_stamp, actual_arrive_time);
\echo
\echo vacuuming
VACUUM ANALYZE passenger_stops;
\echo
\echo computing weekday list for filtering other tables
DROP TABLE IF EXISTS weekdays;
CREATE TABLE weekdays AS
SELECT DISTINCT date_stamp FROM passenger_stops
ORDER BY date_stamp;
CREATE INDEX ON weekdays (date_stamp);
ALTER TABLE weekdays ADD PRIMARY KEY (date_stamp);
