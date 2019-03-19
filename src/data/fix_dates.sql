ALTER TABLE init_veh_stoph ADD COLUMN date_stamp date;
UPDATE init_veh_stoph SET date_stamp = to_date(opd_date, 'DDMONYY');

ALTER TABLE trimet_stop_event ADD COLUMN date_stamp date;
UPDATE trimet_stop_event SET date_stamp = to_date(service_date, 'DDMONYY');
