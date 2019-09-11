DROP TABLE IF EXISTS bus_am_rush_summary;
CREATE TABLE bus_am_rush_summary AS
  SELECT location_id, stop_name, route_number, direction, 
    passenger_stop_locations.longitude, passenger_stop_locations.latitude,
    passenger_stop_locations.geom_point_4326, count(seconds_late) as samples,
    percentile_cont(0.05) within group (order by seconds_late) AS p05_seconds_late,
    percentile_cont(0.25) within group (order by seconds_late) AS q1_seconds_late,
    percentile_cont(0.50) within group (order by seconds_late) AS median_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) AS q3_seconds_late,
    percentile_cont(0.95) within group (order by seconds_late) AS p95_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) -
      percentile_cont(0.25) within group (order by seconds_late) AS iqr_seconds_late,
    sum(ons) AS total_ons, sum(offs) AS total_offs
  FROM bus_passenger_stops
  INNER JOIN passenger_stop_locations ON (location_id = stop_id)
  WHERE service_key = 'W'
  AND arrive_quarter_hour BETWEEN 6.5 AND 8.75
  GROUP BY location_id, stop_name, route_number, direction,
    passenger_stop_locations.longitude, passenger_stop_locations.latitude,
    passenger_stop_locations.geom_point_4326
  ORDER BY location_id, route_number, direction
;
ALTER TABLE bus_am_rush_summary ADD COLUMN id serial;
ALTER TABLE bus_am_rush_summary ADD PRIMARY KEY (id);

DROP TABLE IF EXISTS rail_am_rush_summary;
CREATE TABLE rail_am_rush_summary AS
  SELECT location_id, stop_name, route_number, direction, 
    passenger_stop_locations.longitude, passenger_stop_locations.latitude,
    passenger_stop_locations.geom_point_4326, count(seconds_late) as samples,
    percentile_cont(0.05) within group (order by seconds_late) AS p05_seconds_late,
    percentile_cont(0.25) within group (order by seconds_late) AS q1_seconds_late,
    percentile_cont(0.50) within group (order by seconds_late) AS median_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) AS q3_seconds_late,
    percentile_cont(0.95) within group (order by seconds_late) AS p95_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) -
      percentile_cont(0.25) within group (order by seconds_late) AS iqr_seconds_late,
    sum(ons) AS total_ons, sum(offs) AS total_offs
  FROM rail_passenger_stops
  INNER JOIN passenger_stop_locations ON (location_id = stop_id)
  WHERE service_key = 'A'
  AND arrive_quarter_hour BETWEEN 6.5 AND 8.75
  GROUP BY location_id, stop_name, route_number, direction,
    passenger_stop_locations.longitude, passenger_stop_locations.latitude,
    passenger_stop_locations.geom_point_4326
  ORDER BY location_id, route_number, direction
;
ALTER TABLE rail_am_rush_summary ADD COLUMN id serial;
ALTER TABLE rail_am_rush_summary ADD PRIMARY KEY (id);

DROP TABLE IF EXISTS bus_pm_rush_summary;
CREATE TABLE bus_pm_rush_summary AS
  SELECT location_id, stop_name, route_number, direction, 
    passenger_stop_locations.longitude, passenger_stop_locations.latitude,
    passenger_stop_locations.geom_point_4326, count(seconds_late) as samples,
    percentile_cont(0.05) within group (order by seconds_late) AS p05_seconds_late,
    percentile_cont(0.25) within group (order by seconds_late) AS q1_seconds_late,
    percentile_cont(0.50) within group (order by seconds_late) AS median_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) AS q3_seconds_late,
    percentile_cont(0.95) within group (order by seconds_late) AS p95_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) -
      percentile_cont(0.25) within group (order by seconds_late) AS iqr_seconds_late,
    sum(ons) AS total_ons, sum(offs) AS total_offs
  FROM bus_passenger_stops
  INNER JOIN passenger_stop_locations ON (location_id = stop_id)
  WHERE service_key = 'W'
  AND arrive_quarter_hour BETWEEN 14.5 AND 18.5
  GROUP BY location_id, stop_name, route_number, direction,
    passenger_stop_locations.longitude, passenger_stop_locations.latitude,
    passenger_stop_locations.geom_point_4326
  ORDER BY location_id, route_number, direction
;
ALTER TABLE bus_pm_rush_summary ADD COLUMN id serial;
ALTER TABLE bus_pm_rush_summary ADD PRIMARY KEY (id);

DROP TABLE IF EXISTS rail_pm_rush_summary;
CREATE TABLE rail_pm_rush_summary AS
  SELECT location_id, stop_name, route_number, direction, 
    passenger_stop_locations.longitude, passenger_stop_locations.latitude,
    passenger_stop_locations.geom_point_4326, count(seconds_late) as samples,
    percentile_cont(0.05) within group (order by seconds_late) AS p05_seconds_late,
    percentile_cont(0.25) within group (order by seconds_late) AS q1_seconds_late,
    percentile_cont(0.50) within group (order by seconds_late) AS median_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) AS q3_seconds_late,
    percentile_cont(0.95) within group (order by seconds_late) AS p95_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) -
      percentile_cont(0.25) within group (order by seconds_late) AS iqr_seconds_late,
    sum(ons) AS total_ons, sum(offs) AS total_offs
  FROM rail_passenger_stops
  INNER JOIN passenger_stop_locations ON (location_id = stop_id)
  WHERE service_key = 'A'
  AND arrive_quarter_hour BETWEEN 14.5 AND 18.5
  GROUP BY location_id, stop_name, route_number, direction,
    passenger_stop_locations.longitude, passenger_stop_locations.latitude,
    passenger_stop_locations.geom_point_4326
  ORDER BY location_id, route_number, direction
;
ALTER TABLE rail_pm_rush_summary ADD COLUMN id serial;
ALTER TABLE rail_pm_rush_summary ADD PRIMARY KEY (id);
