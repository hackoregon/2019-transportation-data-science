SELECT AddGeometryColumn ('rail_passenger_stops', 'geom_point_4326', 4326, 'POINT', 2);
UPDATE rail_passenger_stops SET geom_point_4326 = 
  ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326);
SELECT AddGeometryColumn ('bus_passenger_stops', 'geom_point_4326', 4326, 'POINT', 2);
UPDATE bus_passenger_stops SET geom_point_4326 = 
  ST_Transform(ST_SetSRID(ST_MakePoint(x_coordinate, y_coordinate), 2913), 4326);
SELECT AddGeometryColumn ('bus_all_stops', 'geom_point_4326', 4326, 'POINT', 2);
UPDATE bus_all_stops SET geom_point_4326 = 
  ST_SetSRID(ST_MakePoint(gps_longitude, gps_latitude), 4326);
