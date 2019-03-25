\echo The term *trip* has some ambiguities in the data descriptions we have.
\echo As a result, we define an unambiguous concept of a *run*. A run is 
\echo defined as a specific vehicle on a specific service date traversing a
\echo specific route in a specific direction from its arrival at its first
\echo stop to its departure from its last stop.
SET search_path TO :schema, public;
DROP TABLE IF EXISTS runs_table;
CREATE TABLE runs_table AS
SELECT DISTINCT 
  service_date, route_number, direction,
  min(arrive_time) AS first, max(leave_time) AS last, COUNT(location_id) AS stops,
  trip_number, vehicle_number
FROM trimet_stop_event
GROUP BY service_date, route_number, direction, trip_number, vehicle_number
ORDER BY service_date, route_number, direction, first;
CREATE INDEX ON runs_table (service_date);
CREATE INDEX ON runs_table (first);
CREATE INDEX ON runs_table (last);
CREATE INDEX ON runs_table (trip_number);
CREATE INDEX ON runs_table (vehicle_number);
\echo computing weekday list for filtering disturbance stops
CREATE TABLE weekdays AS
SELECT DISTINCT service_date FROM runs_table
ORDER BY service_date;
CREATE INDEX ON weekdays (service_date);
