DROP TABLE IF EXISTS passenger_stops_trips CASCADE;
CREATE TABLE passenger_stops_trips AS
SELECT DISTINCT vehicle_number, train, trip_number, date_stamp::date AS service_date, service_key,
  route_number, direction
FROM raw.raw_stop_event
WHERE vehicle_number > 0
AND train > 0
AND trip_number > 0
AND service_key IS NOT NULL
AND route_number > 0
AND route_number <= 291
;
ALTER TABLE passenger_stops_trips ADD COLUMN passenger_stops_trips_key serial;
ALTER TABLE passenger_stops_trips ADD PRIMARY KEY (passenger_stops_trips_key);
