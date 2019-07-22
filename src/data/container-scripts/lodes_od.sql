\echo setting search path and timezone
SET search_path TO public;
SET timezone = 'PST8PDT';

\echo creating tables
DROP TABLE IF EXISTS lodes_od CASCADE;
CREATE TABLE lodes_od (
  state text,
  part text,
  job_type text,
  year integer,
  w_geocode text,
  h_geocode text,
  segment text,
  value double precision
);

\echo loading lodes_od
COPY lodes_od FROM '/Work/LODES/lodes_od.csv' WITH csv header;

\echo primary key
ALTER TABLE lodes_od ADD COLUMN id serial;
ALTER TABLE lodes_od ADD PRIMARY KEY (id);
