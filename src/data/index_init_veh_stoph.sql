\echo
\echo deleting unwanted rows
DELETE FROM init_veh_stoph
  WHERE opd_date NOT IN (SELECT service_date FROM weekdays)
;
\echo
\echo indexing
CREATE INDEX ON init_veh_stoph (opd_date);
CREATE INDEX ON init_veh_stoph (vehicle_id);
CREATE INDEX ON init_veh_stoph (event_no_trip);
CREATE INDEX ON init_veh_stoph (act_arr_time);
CREATE INDEX ON init_veh_stoph (act_dep_time);
CREATE INDEX ON init_veh_stoph (nom_arr_time);
CREATE INDEX ON init_veh_stoph (nom_dep_time);
CREATE INDEX ON init_veh_stoph (point_id);
\echo
\echo primary key
ALTER TABLE init_veh_stoph ADD COLUMN pkey serial;
ALTER TABLE init_veh_stoph ADD PRIMARY KEY (pkey);
