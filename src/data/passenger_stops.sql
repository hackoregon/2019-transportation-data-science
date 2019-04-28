\echo creating bus_passenger_stops table
-- there are no entries for MAX in the other tables, just buses
-- so we have separate bus and rail passenger stop tables
SET timezone = 'PST8PDT';
DROP SEQUENCE IF EXISTS bus_passenger_stops_pkey;
CREATE SEQUENCE bus_passenger_stops_pkey;
DROP TABLE IF EXISTS bus_passenger_stops CASCADE;
\echo loading
CREATE TABLE bus_passenger_stops AS
SELECT vehicle_number AS vehicle_id, to_date(service_date, 'DDMONYYYY:HH24:MI:SS') AS service_date,
  to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') + arrive_time * interval '1 sec' AS arrive_time, 
  to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') + leave_time * interval '1 sec' AS leave_time, 
  to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') + stop_time * interval '1 sec' AS stop_time, 
  route_number, direction, location_id, dwell, door, lift, ons, offs, estimated_load, train_mileage,
  ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326) AS geom_point_4326,
  nextval('bus_passenger_stops_pkey') AS pkey
FROM old_raw.trimet_stop_event
WHERE service_key = 'W'
AND route_number IS NOT NULL
AND route_number <= 291
AND route_number >= 1
UNION ALL
SELECT vehicle_number AS vehicle_id, to_date(service_date, 'DDMONYY:HH24:MI:SS') AS service_date,
  to_timestamp(service_date, 'DDMONYY:HH24:MI:SS') + arrive_time * interval '1 sec' AS arrive_time, 
  to_timestamp(service_date, 'DDMONYY:HH24:MI:SS') + leave_time * interval '1 sec' AS leave_time, 
  to_timestamp(service_date, 'DDMONYY:HH24:MI:SS') + stop_time * interval '1 sec' AS stop_time, 
  route_number, direction, location_id, dwell, door, lift, ons, offs, estimated_load, train_mileage,
  ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326) AS geom_point_4326,
  nextval('bus_passenger_stops_pkey') AS pkey
FROM new_raw.trimet_stop_event
WHERE service_key = 'W'
AND route_number IS NOT NULL
AND route_number <= 291
AND route_number >= 1
;
\echo fixing SRID
SELECT UpdateGeometrySRID('bus_passenger_stops', 'geom_point_4326', 4326);
\echo primary key
ALTER TABLE bus_passenger_stops ADD PRIMARY KEY (pkey);
\echo
\echo computing weekday list for filtering other tables
DROP TABLE IF EXISTS weekdays;
CREATE TABLE weekdays AS
SELECT DISTINCT service_date AS date_stamp
FROM bus_passenger_stops
ORDER BY date_stamp;
CREATE INDEX ON weekdays (date_stamp);
ALTER TABLE weekdays ADD PRIMARY KEY (date_stamp);
\echo
\echo creating rail_passenger_stops table
DROP SEQUENCE IF EXISTS rail_passenger_stops_pkey;
CREATE SEQUENCE rail_passenger_stops_pkey;
DROP TABLE IF EXISTS rail_passenger_stops CASCADE;
\echo loading
CREATE TABLE rail_passenger_stops AS
SELECT vehicle_number AS vehicle_id, to_date(service_date, 'DDMONYYYY:HH24:MI:SS') AS service_date,
  to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') + arrive_time * interval '1 sec' AS arrive_time, 
  to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') + leave_time * interval '1 sec' AS leave_time, 
  to_timestamp(service_date, 'DDMONYYYY:HH24:MI:SS') + stop_time * interval '1 sec' AS stop_time, 
  route_number, direction, location_id, dwell, door, lift, ons, offs, estimated_load, train_mileage,
  ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326) AS geom_point_4326,
  nextval('rail_passenger_stops_pkey') AS pkey
FROM old_raw.trimet_stop_event
WHERE service_key = 'A'
AND route_number IS NOT NULL
AND route_number <= 291
AND route_number >= 1
UNION ALL
SELECT vehicle_number AS vehicle_id, to_date(service_date, 'DDMONYY:HH24:MI:SS') AS service_date,
  to_timestamp(service_date, 'DDMONYY:HH24:MI:SS') + arrive_time * interval '1 sec' AS arrive_time, 
  to_timestamp(service_date, 'DDMONYY:HH24:MI:SS') + leave_time * interval '1 sec' AS leave_time, 
  to_timestamp(service_date, 'DDMONYY:HH24:MI:SS') + stop_time * interval '1 sec' AS stop_time, 
  route_number, direction, location_id, dwell, door, lift, ons, offs, estimated_load, train_mileage,
  ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326) AS geom_point_4326,
  nextval('rail_passenger_stops_pkey') AS pkey
FROM new_raw.trimet_stop_event
WHERE service_key = 'A'
AND route_number IS NOT NULL
AND route_number <= 291
AND route_number >= 1
;
\echo fixing SRID
SELECT UpdateGeometrySRID('rail_passenger_stops', 'geom_point_4326', 4326);
\echo primary key
ALTER TABLE rail_passenger_stops ADD PRIMARY KEY (pkey);
