\echo creating passenger_stops table
-- there are no entries for MAX in the other tables, just buses
-- so we can save space by not keeping MAX stop events
SET timezone = 'PST8PDT';
DROP SEQUENCE IF EXISTS passenger_stops_pkey;
CREATE SEQUENCE passenger_stops_pkey;
DROP TABLE IF EXISTS passenger_stops CASCADE;
CREATE TABLE passenger_stops AS
SELECT 
  to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') AS date_stamp, 
  to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') + stop_time * interval '1 sec' AS nom_arr_time, 
  to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') + arrive_time * interval '1 sec' AS act_arr_time, 
  to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') + leave_time * interval '1 sec' AS act_dep_time, 
  vehicle_number, route_number, direction, location_id, 
  dwell, door, lift, ons, offs, estimated_load, train_mileage
FROM trimet_stop_event
WHERE service_key = 'W'
AND route_number IS NOT NULL
AND route_number <= 291
AND route_number >= 1;
\echo
\echo primary key
ALTER TABLE passenger_stops ADD PRIMARY KEY (passenger_stops_pkey);
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
