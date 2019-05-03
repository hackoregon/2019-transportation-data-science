\echo creating bus_all_stops table
SET timezone = 'PST8PDT';
DROP SEQUENCE IF EXISTS bus_all_stops_id;
CREATE SEQUENCE bus_all_stops_id;
DROP TABLE IF EXISTS bus_all_stops CASCADE;
\echo loading
CREATE TABLE bus_all_stops AS
SELECT vehicle_id, to_date(opd_date, 'DDMONYYYY:HH24:MI:SS') AS opd_date,
  act_arr_time, act_dep_time, nom_arr_time, nom_dep_time, 
  event_no_trip, meters, stop_id, stop_pos, distance_to_next, distance_to_trip,
  doors_opening, stop_type, door_open_time,
  gps_longitude, gps_latitude, nextval(bus_all_stops_id) AS id
FROM old_raw.init_veh_stoph
WHERE event_no_trip IN (SELECT event_no_trip FROM bus_trips)
UNION ALL
SELECT vehicle_id, to_date(opd_date, 'DDMONYY:HH24:MI:SS') AS opd_date,
  act_arr_time, act_dep_time, nom_arr_time, nom_dep_time, 
  event_no_trip, meters, stop_id, stop_pos, distance_to_next, distance_to_trip,
  doors_opening, stop_type, door_open_time,
  gps_longitude, gps_latitude, nextval(bus_all_stops_id) AS id
FROM new_raw.init_veh_stoph
WHERE event_no_trip IN (SELECT event_no_trip FROM bus_trips)
;
\echo
\echo primary key
ALTER TABLE bus_all_stops ADD PRIMARY KEY (id);
