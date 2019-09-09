CREATE INDEX ON rail_passenger_stops (
	year,
	month,
	service_key,
	route_number,
	location_id,
	longitude,
	latitude,
	arrive_quarter_hour
);

CREATE INDEX ON bus_passenger_stops (
	year,
	month,
	service_key,
	route_number,
	location_id,
	longitude,
	latitude,
	arrive_quarter_hour
);

