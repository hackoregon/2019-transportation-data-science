DROP TABLE IF EXISTS disturbance_stops_catalog;
CREATE TABLE disturbance_stops_catalog AS
SELECT DISTINCT year, month, line_id, count(id) AS rows
FROM disturbance_stops
GROUP BY year, month, line_id
ORDER BY year, month, line_id;

DROP TABLE IF EXISTS rail_passenger_stops_catalog;
CREATE TABLE rail_passenger_stops_catalog AS
SELECT DISTINCT year, month, route_number, count(id) AS rows
FROM rail_passenger_stops
GROUP BY year, month, route_number
ORDER BY year, month, route_number;

DROP TABLE IF EXISTS bus_passenger_stops_catalog;
CREATE TABLE bus_passenger_stops_catalog AS
SELECT DISTINCT year, month, route_number, count(id) AS rows
FROM bus_passenger_stops
GROUP BY year, month, route_number
ORDER BY year, month, route_number;