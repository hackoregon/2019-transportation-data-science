ALTER TABLE bus_passenger_stops_catalog
ADD COLUMN id serial;
ALTER TABLE bus_passenger_stops_catalog
ADD PRIMARY KEY (id);

ALTER TABLE rail_passenger_stops_catalog
ADD COLUMN id serial;
ALTER TABLE rail_passenger_stops_catalog
ADD PRIMARY KEY (id);

ALTER TABLE disturbance_stops_catalog
ADD COLUMN id serial;
ALTER TABLE disturbance_stops_catalog
ADD PRIMARY KEY (id);

