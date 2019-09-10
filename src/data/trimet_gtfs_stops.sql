SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS trimet_gtfs_stops;
CREATE TABLE trimet_gtfs_stops (
  stop_id text,
  stop_code integer,
  stop_name text,
  tts_stop_name text,
  stop_desc text,
  stop_lat double precision,
  stop_lon double precision,
  zone_id text,
  stop_url text,
  location_type text,
  parent_station text,
  direction text,
  position text
);
COPY trimet_gtfs_stops FROM '/Raw/trimet_gtfs_stops.csv' WITH csv header;
ALTER TABLE trimet_gtfs_stops ADD COLUMN id serial;
ALTER TABLE trimet_gtfs_stops ADD PRIMARY KEY (id);
