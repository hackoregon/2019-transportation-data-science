SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS trips_history;
CREATE TABLE trips_history AS
SELECT to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') AS date_stamp, event_no AS event_no_trip,
  vehicle_id, nom_dep_time, act_dep_time, nom_end_time, act_end_time, 
  line_id, pattern_direction
FROM init_tripsh
WHERE to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS') IN (SELECT date_stamp FROM weekdays)
AND pattern_direction IS NOT NULL
AND line_id IS NOT NULL
AND line_id <= 291
AND line_id >= 1;
\echo
\echo indexing
CREATE INDEX ON trips_history (date_stamp);
CREATE INDEX ON trips_history (vehicle_id);
CREATE INDEX ON trips_history (event_no_trip);
CREATE INDEX ON trips_history (line_id, pattern_direction);
\echo
\echo primary key
ALTER TABLE trips_history ADD PRIMARY KEY (event_no_trip);
\echo
\echo vacuuming
VACUUM ANALYZE trips_history;
