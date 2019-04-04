\echo geotagging
CREATE EXTENSION IF NOT EXISTS postgis;
ALTER TABLE init_veh_stoph ADD COLUMN geom_point_4326 geometry;
UPDATE init_veh_stoph SET geom_point_4326 = ST_SetSRID(ST_MakePoint(gps_longitude, gps_latitude), 4326);
CREATE INDEX ON init_veh_stoph USING GIST (geom_point_4326);
