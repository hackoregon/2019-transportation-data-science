\echo setting search path and timezone
SET search_path TO public;
SET timezone = 'PST8PDT';
\echo creating tables
DROP TABLE IF EXISTS passenger_census CASCADE;
CREATE TABLE passenger_census (
  summary_begin_date date,
  route_number integer,
  direction integer,
  service_key text,
  stop_seq integer,
  location_id integer,
  public_location_description text,
  ons integer,
  offs integer,
  x_coord double precision,
  y_coord double precision
);
\echo loading passenger_census
\copy passenger_census from '/Raw/passenger_census.csv' with csv header
\echo primary key
ALTER TABLE passenger_census ADD COLUMN id serial;
ALTER TABLE passenger_census ADD PRIMARY KEY (id);
