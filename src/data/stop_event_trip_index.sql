SET timezone = 'PST8PDT';
DROP INDEX IF EXISTS raw.trip_index;
CREATE INDEX trip_index ON raw.raw_stop_event (
	vehicle_number, train, trip_number, date_stamp, route_number, direction
);
