SET timezone = 'PST8PDT';
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
COPY passenger_census FROM '/Work/passenger_census.csv' WITH csv header;
ALTER TABLE passenger_census ADD COLUMN id serial;
ALTER TABLE passenger_census ADD PRIMARY KEY (serial);
