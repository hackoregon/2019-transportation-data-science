\echo The term *trip* has some ambiguities in the data descriptions we have.
\echo As a result, we define an unambiguous concept of a *run*. A run is 
\echo defined as a specific vehicle on a specific service date traversing a
\echo specific route in a specific direction from its arrival at its first
\echo stop to its departure from its last stop.
DROP TABLE IF EXISTS :runs_table;
CREATE TABLE :runs_table AS
SELECT DISTINCT 
  date_stamp, route_number, direction,
  min(arrive_time) AS first, max(leave_time) AS last, COUNT(location_id) AS stops,
  trip_number, vehicle_number
FROM :trimet_stop_event
GROUP BY date_stamp, route_number, direction, trip_number, vehicle_number
ORDER BY date_stamp, route_number, direction, first;
