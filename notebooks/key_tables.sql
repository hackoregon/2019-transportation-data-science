ALTER TABLE init_cyclic_v1h ADD COLUMN date_stamp date;
UPDATE init_cyclic_v1h SET date_stamp = to_date(opd_date, 'DDMONYY');
ALTER TABLE init_cyclic_v1h ADD COLUMN pkey serial;
ALTER TABLE init_cyclic_v1h ADD PRIMARY KEY (pkey);

ALTER TABLE init_veh_stoph ADD COLUMN date_stamp date;
UPDATE init_cyclic_v1h SET date_stamp = to_date(opd_date, 'DDMONYY');
ALTER TABLE init_veh_stoph ADD COLUMN pkey serial;
ALTER TABLE init_veh_stoph ADD PRIMARY KEY (pkey);

ALTER TABLE trimet_stop_event ADD COLUMN date_stamp date;
UPDATE init_cyclic_v1h SET date_stamp = to_date(service_date, 'DDMONYY');
ALTER TABLE trimet_stop_event ADD COLUMN pkey serial;
ALTER TABLE trimet_stop_event ADD PRIMARY KEY (pkey);

ALTER TABLE init_tripsh ADD COLUMN date_stamp date;
UPDATE init_cyclic_v1h SET date_stamp = to_date(opd_date, 'DDMONYY');
ALTER TABLE init_tripsh ADD COLUMN pkey serial;
ALTER TABLE init_tripsh ADD PRIMARY KEY (pkey);
