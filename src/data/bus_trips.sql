\echo creating bus_trips table
SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS bus_trips CASCADE;
CREATE TABLE bus_trips AS
SELECT vehicle_id, event_no AS event_no_trip,
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + act_dep_time * interval '1 sec' AS act_dep_time, 
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + act_end_time * interval '1 sec' AS act_end_time, 
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + nom_dep_time * interval '1 sec' AS nom_dep_time, 
  to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') + nom_end_time * interval '1 sec' AS nom_end_time, 
  meters, line_id, pattern_direction
FROM init_tripsh
WHERE to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') IN (SELECT date_stamp FROM weekdays)
AND pattern_direction IS NOT NULL
AND line_id IS NOT NULL
AND line_id <= 291
AND line_id >= 1;
\echo
\echo primary key
ALTER TABLE bus_trips ADD PRIMARY KEY (event_no_trip);
