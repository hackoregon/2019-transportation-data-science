\echo creating stops table
SET timezone = 'PST8PDT';
DROP SEQUENCE IF EXISTS stops_pkey;
CREATE SEQUENCE stops_pkey;
DROP TABLE IF EXISTS stops CASCADE;
CREATE TABLE stops AS
SELECT 
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') AS date_stamp,
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + nom_arr_time * interval '1 sec' AS nom_arr_time, 
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + act_arr_time * interval '1 sec' AS act_arr_time, 
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + nom_dep_time * interval '1 sec' AS nom_dep_time, 
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + act_dep_time * interval '1 sec' AS act_dep_time, 
  event_no_trip, vehicle_id, meters, stop_id, stop_pos, distance_to_next,
  distance_to_trip, doors_opening, stop_type, door_open_time,
  ST_SetSRID(ST_MakePoint(gps_longitude, gps_latitude), 4326) AS geom_point_4326
FROM init_veh_stoph
WHERE event_no_trip IN (SELECT event_no_trip FROM trips_history);
\echo
\echo primary key
ALTER TABLE stops ADD PRIMARY KEY (stops_pkey);
\echo
\echo vacuuming
VACUUM ANALYZE stops;
