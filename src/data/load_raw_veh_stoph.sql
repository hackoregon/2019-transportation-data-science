\echo setting search path and timezone
SET search_path TO raw, public;
SET timezone = 'PST8PDT';

\echo creating tables
DROP TABLE IF EXISTS raw_veh_stoph CASCADE;
CREATE TABLE raw_veh_stoph (
  event_no_trip integer,
  opd_date text,
  vehicle_id integer,
  meters integer,
  act_arr_time integer,
  act_dep_time integer,
  nom_arr_time integer,
  nom_dep_time integer,
  stop_id integer,
  stop_pos integer,
  distance_to_next integer,
  distance_to_trip integer,
  doors_opening integer,
  stop_type integer,
  gps_longitude double precision,
  gps_latitude double precision,
  door_open_time integer
);

\echo loading raw_veh_stoph
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2017_09.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2017_10.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2017_11.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2018_04.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2018_05.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2018_09.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2018_10.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2018_11.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2019_04.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2019_05.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2019_06.csv' WITH csv header;
COPY raw_veh_stoph FROM '/Work/raw_veh_stoph_2019_07.csv' WITH csv header;

\echo removing stops except disturbance stops
DELETE FROM raw_veh_stoph
WHERE stop_type IS NULL
OR gps_longitude IS NULL
OR gps_latitude IS NULL
OR stop_type != 3;
\echo date stamps on raw_veh_stoph
ALTER TABLE raw_veh_stoph ADD COLUMN date_stamp timestamp with time zone;
UPDATE raw_veh_stoph SET date_stamp = to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS');
