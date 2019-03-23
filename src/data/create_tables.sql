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

\echo creating trimet stop event
DROP TABLE IF EXISTS :trimet_stop_event;
CREATE TABLE :trimet_stop_event
(
    service_date text,
    vehicle_number integer,
    leave_time integer,
    train integer,
    badge integer,
    route_number integer,
    direction integer,
    service_key text,
    trip_number integer,
    stop_time integer,
    arrive_time integer,
    dwell integer,
    location_id integer,
    door integer,
    lift integer,
    ons integer,
    offs integer,
    estimated_load integer,
    maximum_speed integer,
    train_mileage real,
    pattern_distance real,
    location_distance real,
    x_coordinate real,
    y_coordinate real,
    data_source integer,
    schedule_status integer
);
COPY :trimet_stop_event FROM :trimet_stop_event_csv WITH csv header;
