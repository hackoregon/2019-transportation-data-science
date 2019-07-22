\echo setting search path and timezone
SET search_path TO raw, public;
SET timezone = 'PST8PDT';

\echo creating tables
DROP TABLE IF EXISTS raw_tripsh CASCADE;
CREATE TABLE raw_tripsh (
  opd_date text,
  vehicle_id integer,
  event_no integer,
  meters integer,
  act_dep_time integer,
  nom_dep_time integer,
  nom_end_time integer,
  act_end_time integer,
  line_id integer,
  pattern_direction text
);

\echo loading raw_tripsh
COPY raw_tripsh FROM '/Work/raw_tripsh_2017_09.csv' WITH csv header;
COPY raw_tripsh FROM '/Work/raw_tripsh_2017_10.csv' WITH csv header;
COPY raw_tripsh FROM '/Work/raw_tripsh_2017_11.csv' WITH csv header;
COPY raw_tripsh FROM '/Work/raw_tripsh_2018_09.csv' WITH csv header;
COPY raw_tripsh FROM '/Work/raw_tripsh_2018_10.csv' WITH csv header;
COPY raw_tripsh FROM '/Work/raw_tripsh_2018_11.csv' WITH csv header;

\echo date stamps on raw_tripsh
ALTER TABLE raw_tripsh ADD COLUMN date_stamp timestamp with time zone;
UPDATE raw_tripsh SET date_stamp = to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS');
