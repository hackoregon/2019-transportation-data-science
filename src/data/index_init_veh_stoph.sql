\echo parsing dates
SET timezone = 'PST8PDT';
ALTER TABLE init_veh_stoph ADD COLUMN date_stamp timestamp with time zone;
UPDATE init_veh_stoph SET date_stamp = to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS');
\echo
\echo deleting unwanted rows
DELETE FROM init_veh_stoph
  WHERE date_stamp NOT IN (SELECT date_stamp FROM weekdays)
;
\echo
\echo indexing
CREATE INDEX ON init_veh_stoph (date_stamp);
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
