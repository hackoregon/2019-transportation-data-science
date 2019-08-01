SELECT * FROM bus_passenger_stops
WHERE route_number = 20
AND service_key = 'W'
AND arrive_quarter_hour BETWEEN 15.5 AND 18.75
;
