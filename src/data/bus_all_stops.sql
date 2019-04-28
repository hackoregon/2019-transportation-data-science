\echo creating bus_all_stops table
SET timezone = 'PST8PDT';
DROP SEQUENCE IF EXISTS bus_all_stops_pkey;
CREATE SEQUENCE bus_all_stops_pkey;
DROP TABLE IF EXISTS bus_all_stops CASCADE;
\echo loading
CREATE TABLE bus_all_stops AS
SELECT vehicle_id, to_date(opd_date, 'DDMONYYYY:HH24:MI:SS') AS opd_date,
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + act_arr_time * interval '1 sec' AS act_arr_time, 
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + act_dep_time * interval '1 sec' AS act_dep_time, 
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + nom_arr_time * interval '1 sec' AS nom_arr_time, 
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + nom_dep_time * interval '1 sec' AS nom_dep_time, 
  event_no_trip, meters, stop_id, stop_pos, distance_to_next, distance_to_trip,
  doors_opening, stop_type, door_open_time,
  ST_SetSRID(ST_MakePoint(gps_longitude, gps_latitude), 4326) AS geom_point_4326,
  nextval('bus_all_stops_pkey') AS pkey
FROM old_raw.init_veh_stoph
WHERE event_no_trip IN (SELECT event_no_trip FROM bus_trips)
UNION ALL
SELECT vehicle_id, to_date(opd_date, 'DDMONYY:HH24:MI:SS') AS opd_date,
  to_timestamp(opd_date, 'DDMONYY:HH24:MI:SS') + act_arr_time * interval '1 sec' AS act_arr_time, 
  to_timestamp(opd_date, 'DDMONYY:HH24:MI:SS') + act_dep_time * interval '1 sec' AS act_dep_time, 
  to_timestamp(opd_date, 'DDMONYY:HH24:MI:SS') + nom_arr_time * interval '1 sec' AS nom_arr_time, 
  to_timestamp(opd_date, 'DDMONYY:HH24:MI:SS') + nom_dep_time * interval '1 sec' AS nom_dep_time, 
  event_no_trip, meters, stop_id, stop_pos, distance_to_next, distance_to_trip,
  doors_opening, stop_type, door_open_time,
  ST_SetSRID(ST_MakePoint(gps_longitude, gps_latitude), 4326) AS geom_point_4326,
  nextval('bus_all_stops_pkey') AS pkey
FROM new_raw.init_veh_stoph
WHERE event_no_trip IN (SELECT event_no_trip FROM bus_trips)
;
\echo fixing SRID
SELECT UpdateGeometrySRID('bus_all_stops', 'geom_point_4326', 4326);
\echo
\echo primary key
ALTER TABLE bus_all_stops ADD PRIMARY KEY (pkey);
