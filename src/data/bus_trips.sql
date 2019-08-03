\echo creating bus_trips table
SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS bus_trips CASCADE;
\echo loading
CREATE TABLE bus_trips AS
SELECT vehicle_id, date_stamp:: date AS opd_date,
  date_stamp + act_dep_time * interval '1 sec' AS act_dep_time,
  date_stamp + act_end_time * interval '1 sec' AS act_end_time,
  date_stamp + nom_dep_time * interval '1 sec' AS nom_dep_time,
  date_stamp + nom_end_time * interval '1 sec' AS nom_end_time,
  event_no AS event_no_trip, meters, line_id, pattern_direction
FROM raw.raw_tripsh
WHERE pattern_direction IS NOT NULL
AND line_id IS NOT NULL
AND line_id <= 291
AND line_id >= 1;
\echo primary key
ALTER TABLE bus_trips ADD PRIMARY KEY (event_no_trip);
DROP TABLE IF EXISTS bus_routes;
CREATE TABLE bus_routes AS
SELECT DISTINCT line_id FROM bus_trips ORDER BY line_id;
ALTER TABLE bus_routes ADD PRIMARY KEY (line_id);
\echo truncating input table
TRUNCATE TABLE raw.raw_tripsh;
