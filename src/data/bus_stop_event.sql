\echo creating passenger_stop_event table
-- there are no entries for MAX in the other tables, just buses
-- so we can save space by not keeping MAX stop events
SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS passenger_stop_event;
CREATE TABLE passenger_stop_event AS
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
CREATE INDEX ON passenger_stop_event (date_stamp);
CREATE INDEX ON passenger_stop_event (vehicle_number);
CREATE INDEX ON passenger_stop_event (route_number, direction);
CREATE INDEX ON passenger_stop_event (location_id);
CREATE INDEX ON passenger_stop_event (scheduled_arrive_time);
CREATE INDEX ON passenger_stop_event (actual_arrive_time);
CREATE INDEX ON passenger_stop_event (leave_time);
CREATE INDEX ON passenger_stop_event USING GIST (geom_point_4326);
\echo
\echo primary key
ALTER TABLE passenger_stop_event ADD PRIMARY KEY (vehicle_number, date_stamp, actual_arrive_time);
\echo
\echo vacuuming
VACUUM ANALYZE passenger_stop_event;
\echo
\echo computing weekday list for filtering other tables
CREATE TABLE weekdays AS
SELECT DISTINCT date_stamp FROM passenger_stop_event
ORDER BY date_stamp;
CREATE INDEX ON weekdays (date_stamp);
ALTER TABLE weekdays ADD PRIMARY KEY (date_stamp);
