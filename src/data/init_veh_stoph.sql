\echo creating vehicle stop history
DROP TABLE IF EXISTS :init_veh_stoph;
CREATE TABLE :init_veh_stoph
(
    event_no integer,
    event_no_trip integer,
    event_no_prev integer,
    opd_date text,
    vehicle_id integer,
    master_id text,
    meters integer,
    act_arr_time integer,
    act_dep_time integer,
    nom_arr_time integer,
    nom_dep_time integer,
    point_id integer,
    stop_id integer,
    stop_pos integer,
    distance_to_next integer,
    distance_to_trip integer,
    doors_opening integer,
    positioning_method integer,
    stop_type integer,
    gps_longitude real,
    gps_latitude real,
    pattern_idx integer,
    door_open_time integer,
    point_role text,
    point_action text,
    plan_status text
);
COPY :init_veh_stoph FROM :init_veh_stoph_csv WITH csv header;
