SET search_path TO :schema, public;

\echo indexing the variables that define events
CREATE INDEX ON init_veh_stoph (opd_date);
CREATE INDEX ON init_veh_stoph (vehicle_id);
CREATE INDEX ON init_veh_stoph (act_arr_time);
CREATE INDEX ON init_veh_stoph (act_dep_time);
CREATE INDEX ON init_veh_stoph (nom_arr_time);
CREATE INDEX ON init_veh_stoph (nom_dep_time);
