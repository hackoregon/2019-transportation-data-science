ALTER TABLE bus_passenger_stops ADD COLUMN IF NOT EXISTS seconds_late integer;
ALTER TABLE bus_passenger_stops ADD COLUMN IF NOT EXISTS arriving_load integer;
ALTER TABLE bus_passenger_stops ADD COLUMN IF NOT EXISTS arrive_quarter_hour double precision;
UPDATE bus_passenger_stops
SET seconds_late = extract('epoch' from (arrive_time - stop_time)),
  arriving_load = estimated_load - ons + offs,
  arrive_quarter_hour = 0.25*trunc(
	4*date_part('hour', arrive_time AT TIME ZONE 'America/Los_Angeles') +
	date_part('minute', arrive_time AT TIME ZONE 'America/Los_Angeles')/15
  )
;
