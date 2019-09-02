SET timezone = 'PST8PDT';
CREATE TEMPORARY TABLE raw_passenger_census (
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
COPY raw_passenger_census FROM '/Raw/passenger_census.csv' WITH csv header;
ALTER TABLE raw_passenger_census
  ADD COLUMN longitude double precision,
  ADD COLUMN latitude double precision,
  ADD COLUMN geom_point_4326 geometry(POINT, 4326)
;
UPDATE raw_passenger_census SET
  longitude = ST_X(ST_Transform(ST_SetSRID(ST_MakePoint(x_coord, y_coord), 2913), 4326)),
  latitude = ST_Y(ST_Transform(ST_SetSRID(ST_MakePoint(x_coord, y_coord), 2913), 4326)),
  geom_point_4326 = ST_Transform(ST_SetSRID(ST_MakePoint(x_coord, y_coord), 2913), 4326)
;

DROP TABLE IF EXISTS passenger_census CASCADE;
CREATE TABLE passenger_census AS SELECT
  summary_begin_date,
  route_number,
  direction,
  service_key,
  stop_seq,
  location_id,
  public_location_description,
  ons,
  offs,
  x_coord,
  y_coord,
  longitude,
  latitude,
  geom_point_4326,
  geoid AS census_tract_2010
FROM raw_passenger_census
LEFT JOIN trimet_tract_boundaries ON ST_Within(
  raw_passenger_census.geom_point_4326, trimet_tract_boundaries.geom_multpoly_4326
);
ALTER TABLE passenger_census ADD COLUMN id serial;
ALTER TABLE passenger_census ADD PRIMARY KEY (id);
