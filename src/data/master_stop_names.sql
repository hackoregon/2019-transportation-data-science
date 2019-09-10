DROP TABLE IF EXISTS raw_stop_names;
CREATE TEMPORARY TABLE raw_stop_names AS
    SELECT stop_id, stop_name FROM trimet_gis.tm_stops
    UNION SELECT stop_id, stop_name FROM trimet_gis.tm_route_stops
    UNION SELECT DISTINCT location_id AS stop_id,
	    public_location_description AS stop_name FROM passenger_census
;
DROP TABLE IF EXISTS master_stop_names;
CREATE TABLE master_stop_names AS
SELECT DISTINCT stop_id, stop_name
FROM raw_stop_names
ORDER BY stop_id;
SELECT DISTINCT location_id FROM bus_am_rush_summary
WHERE location_id NOT IN (
	SELECT stop_id FROM master_stop_names
);
