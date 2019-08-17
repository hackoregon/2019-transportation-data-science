SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS passenger_stops_trips CASCADE;
CREATE TABLE passenger_stops_trips AS
SELECT DISTINCT date_stamp AS service_date,
    vehicle_number, train, route_number, direction, service_key, trip_number,
	COUNT(location_id) AS stop_count
FROM raw.raw_stop_event
WHERE vehicle_number > 0
AND train > 0
AND trip_number > 0
AND service_key IS NOT NULL
AND route_number > 0
AND route_number <= 291
GROUP BY date_stamp,
    vehicle_number, train, route_number, direction, service_key, trip_number
ORDER BY vehicle_number, service_date, trip_number
;
ALTER TABLE passenger_stops_trips ADD COLUMN passenger_stops_trips_key serial;
ALTER TABLE passenger_stops_trips ADD PRIMARY KEY (passenger_stops_trips_key);
