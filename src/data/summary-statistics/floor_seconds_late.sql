UPDATE bus_passenger_stops
SET seconds_late = 0
WHERE seconds_late < 0
;
UPDATE rail_passenger_stops
SET seconds_late = 0
WHERE seconds_late < 0;