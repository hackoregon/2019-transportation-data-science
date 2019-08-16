ALTER TABLE bus_passenger_stops
    ADD COLUMN year integer,
	ADD COLUMN month integer,
	ADD COLUMN gps_longitude double precision,
	ADD COLUMN gps_latitude double precision
;
UPDATE bus_passenger_stops
SET year = extract('year' FROM service_date),
    month = extract('month' FROM service_date),
	gps_longitude = ST_X(geom_point_4326),
	gps_latitude = ST_Y(geom_point_4326)
;

ALTER TABLE rail_passenger_stops
    ADD COLUMN year integer,
	ADD COLUMN month integer,
	ADD COLUMN gps_longitude double precision,
	ADD COLUMN gps_latitude double precision
;
UPDATE rail_passenger_stops
SET year = extract('year' FROM service_date),
    month = extract('month' FROM service_date),
	gps_longitude = ST_X(geom_point_4326),
	gps_latitude = ST_Y(geom_point_4326)
;
