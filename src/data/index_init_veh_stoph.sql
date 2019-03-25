\echo deleting unwanted rows
SET search_path TO :schema, public;
DELETE FROM init_veh_stoph
  WHERE opd_date NOT IN (SELECT service_date FROM weekdays)
;
\echo indexing
CREATE INDEX ON init_veh_stoph (opd_date);
CREATE INDEX ON init_veh_stoph (vehicle_id);
CREATE INDEX ON init_veh_stoph (event_no_trip);
CREATE INDEX ON init_veh_stoph (act_arr_time);
CREATE INDEX ON init_veh_stoph (act_dep_time);
CREATE INDEX ON init_veh_stoph (nom_arr_time);
CREATE INDEX ON init_veh_stoph (nom_dep_time);
CREATE INDEX ON init_veh_stoph (point_id);

\echo geotagging
ALTER TABLE init_veh_stoph ADD COLUMN geom_point_4326 geometry;
UPDATE init_veh_stoph
SET geom_point_4326 = ST_SetSRID(ST_MakePoint(gps_longitude, gps_latitude));

\echo primary key
ALTER TABLE init_veh_stoph ADD COLUMN pkey serial;
ALTER TABLE init_veh_stoph ADD PRIMARY KEY (pkey);
