CREATE INDEX ON rail_passenger_stops(
	route_number,
	direction,
	service_key,
	arrive_quarter_hour
);
