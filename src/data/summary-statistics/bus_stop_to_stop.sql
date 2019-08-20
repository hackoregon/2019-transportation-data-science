SET timezone = 'PST8PDT';
DROP INDEX IF EXISTS bus_trip_index;
CREATE INDEX bus_trip_index ON bus_passenger_stops (
	vehicle_id, train, trip_number, service_date, route_number, direction
);
DROP TABLE IF EXISTS bus_stop_to_stop;
CREATE TABLE bus_stop_to_stop AS
SELECT vehicle_id, train, trip_number, service_date, route_number, direction,
  year, month, day, day_of_week, longitude, latitude, geom_point_4326,
  location_id, LAG(location_id) OVER (
	  PARTITION BY vehicle_id, train, trip_number, service_date, route_number, direction
	  ORDER BY arrive_time
  ) AS previous_location_id,
  arrive_time, LAG(arrive_time) OVER (
	  PARTITION BY vehicle_id, train, trip_number, service_date, route_number, direction
	  ORDER BY arrive_time
  ) AS previous_arrive_time,
  train_mileage, LAG(train_mileage) OVER (
	  PARTITION BY vehicle_id, train, trip_number, service_date, route_number, direction
	  ORDER BY train_mileage
  ) AS previous_train_mileage
FROM bus_passenger_stops
ORDER BY service_date, vehicle_id, arrive_time
;
ALTER TABLE bus_stop_to_stop ADD COLUMN id serial;
ALTER TABLE bus_stop_to_stop ADD PRIMARY KEY (id);
