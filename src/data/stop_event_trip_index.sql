SET timezone = 'PST8PDT';
DROP INDEX IF EXISTS raw.trip_index;
CREATE INDEX trip_index ON raw.raw_stop_event (
	vehicle_number, train, trip_number, date_stamp, route_number, direction
);
DROP TABLE IF EXISTS public.stop_event_trip_codes;
CREATE TABLE public.stop_event_trip_codes AS
SELECT DISTINCT vehicle_number, train, trip_number, date_stamp, route_number, direction
FROM raw.raw_stop_event
WHERE trip_number > 0
AND route_number > 0
ORDER BY vehicle_number, date_stamp, trip_number;
ALTER TABLE public.stop_event_trip_codes ADD COLUMN trip_code_number serial;
ALTER TABLE public.stop_event_trip_codes ADD PRIMARY KEY (trip_code_number);
