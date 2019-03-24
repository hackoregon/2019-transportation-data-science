\echo making a usable date stamp
SET search_path TO init_veh_stoph, public;
ALTER TABLE :init_veh_stoph ADD COLUMN date_stamp date;
UPDATE :init_veh_stoph SET date_stamp = to_date(opd_date, 'DDMONYY');
ALTER TABLE :init_veh_stoph DROP COLUMN IF EXISTS opd_date;

\echo indexing the variables that define events
CREATE INDEX ON :init_veh_stoph (date_stamp);
CREATE INDEX ON :init_veh_stoph (vehicle_id);
CREATE INDEX ON :init_veh_stoph (act_arr_time);
CREATE INDEX ON :init_veh_stoph (act_dep_time);
CREATE INDEX ON :init_veh_stoph (nom_arr_time);
CREATE INDEX ON :init_veh_stoph (nom_dep_time);
