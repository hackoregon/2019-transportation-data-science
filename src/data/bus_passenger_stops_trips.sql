DROP TABLE IF EXISTS bus_passenger_stops_trips CASCADE;
CREATE TABLE bus_passenger_stops_trips AS
	SELECT DISTINCT vehicle_id, train, trip_number, service_date, service_key, route_number, direction,
    	min(arrive_time) AS first_arrival, max(leave_time) AS last_departure
	FROM bus_passenger_stops
	GROUP BY vehicle_id, train, trip_number, service_date, service_key, route_number, direction
	ORDER BY vehicle_id, first_arrival
;
ALTER TABLE bus_passenger_stops_trips ADD COLUMN id serial;
ALTER TABLE bus_passenger_stops_trips ADD PRIMARY KEY (id);