\echo creating stops table
SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS stops;
CREATE TABLE stops AS
SELECT to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') AS date_stamp, event_no_trip, 
  vehicle_id, meters, act_arr_time, act_dep_time, nom_arr_time, nom_dep_time, 
  stop_id, stop_pos, distance_to_next, distance_to_trip, doors_opening, stop_type,
  door_open_time, ST_SetSRID(ST_MakePoint(gps_longitude, gps_latitude), 4326) AS geom_point_4326
FROM init_veh_stoph
WHERE event_no_trip IN (SELECT event_no_trip FROM trips_history);
\echo
\echo indexing
CREATE INDEX ON stops (date_stamp);
CREATE INDEX ON stops (vehicle_id);
CREATE INDEX ON stops (event_no_trip);
CREATE INDEX ON stops (act_arr_time);
CREATE INDEX ON stops (act_dep_time);
CREATE INDEX ON stops (nom_arr_time);
CREATE INDEX ON stops (nom_dep_time);
CREATE INDEX ON stops (stop_id);
CREATE INDEX ON stops USING GIST (geom_point_4326);
\echo
\echo primary key
ALTER TABLE stops ADD PRIMARY KEY (vehicle_id, date_stamp, act_arr_time);
\echo
\echo vacuuming
VACUUM ANALYZE stops;
