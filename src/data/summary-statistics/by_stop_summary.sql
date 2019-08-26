DROP TABLE IF EXISTS bus_by_stop_summary;
CREATE TABLE bus_by_stop_summary AS
  SELECT location_id, route_number, direction, passenger_stop_locations.longitude,
    passenger_stop_locations.latitude, passenger_stop_locations.geom_point_4326,
    arrive_quarter_hour, count(seconds_late) as samples,
    percentile_cont(0.05) within group (order by seconds_late) AS p05_seconds_late,
    percentile_cont(0.25) within group (order by seconds_late) AS q1_seconds_late,
    percentile_cont(0.50) within group (order by seconds_late) AS median_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) AS q3_seconds_late,
    percentile_cont(0.95) within group (order by seconds_late) AS p95_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) -
    percentile_cont(0.25) within group (order by seconds_late) AS iqr_seconds_late,
    sum(ons) AS monthly_total_ons, sum(offs) AS monthly_total_offs
  FROM bus_passenger_stops
  INNER JOIN passenger_stop_locations ON (location_id = stop_id)
  WHERE service_key = 'W'
  GROUP BY location_id, route_number, direction, arrive_quarter_hour,
    passenger_stop_locations.longitude, passenger_stop_locations.latitude,
    passenger_stop_locations.geom_point_4326
  ORDER BY location_id, route_number, direction, arrive_quarter_hour
;
ALTER TABLE bus_by_stop_summary ADD COLUMN id serial;
ALTER TABLE bus_by_stop_summary ADD PRIMARY KEY (id);

DROP TABLE IF EXISTS rail_by_stop_summary;
CREATE TABLE rail_by_stop_summary AS
  SELECT location_id, route_number, direction, passenger_stop_locations.longitude,
    passenger_stop_locations.latitude, passenger_stop_locations.geom_point_4326,
    arrive_quarter_hour, count(seconds_late) as samples,
    percentile_cont(0.05) within group (order by seconds_late) AS p05_seconds_late,
    percentile_cont(0.25) within group (order by seconds_late) AS q1_seconds_late,
    percentile_cont(0.50) within group (order by seconds_late) AS median_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) AS q3_seconds_late,
    percentile_cont(0.95) within group (order by seconds_late) AS p95_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) -
    percentile_cont(0.25) within group (order by seconds_late) AS iqr_seconds_late,
    sum(ons) AS monthly_total_ons, sum(offs) AS monthly_total_offs
  FROM rail_passenger_stops
  INNER JOIN passenger_stop_locations ON (location_id = stop_id)
  WHERE service_key = 'A'
  GROUP BY location_id, route_number, direction, arrive_quarter_hour,
    passenger_stop_locations.longitude, passenger_stop_locations.latitude,
    passenger_stop_locations.geom_point_4326
  ORDER BY location_id, route_number, direction, arrive_quarter_hour
;
ALTER TABLE rail_by_stop_summary ADD COLUMN id serial;
ALTER TABLE rail_by_stop_summary ADD PRIMARY KEY (id);
