DROP TABLE IF EXISTS bus_by_stop_summary;
CREATE TABLE bus_by_stop_summary AS
  SELECT extract('year' from service_date) AS year,
    extract('month' from service_date) AS month,
	route_number, direction, location_id,
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
  WHERE service_key = 'W'
  GROUP BY year, month, route_number, direction, location_id, arrive_quarter_hour
  ORDER BY year, month, route_number, direction, location_id, arrive_quarter_hour
;

DROP TABLE IF EXISTS rail_by_stop_summary;
CREATE TABLE rail_by_stop_summary AS
  SELECT extract('year' from service_date) AS year,
    extract('month' from service_date) AS month,
	route_number, direction, location_id,
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
  WHERE service_key = 'A'
  GROUP BY year, month, route_number, direction, location_id, arrive_quarter_hour
  ORDER BY year, month, route_number, direction, location_id, arrive_quarter_hour
;

DROP TABLE IF EXISTS disturbance_by_stop_summary;
CREATE TABLE disturbance_by_stop_summary AS
  SELECT year, month, line_id, pattern_direction,
    start_quarter_hour, count(duration) as samples,
    percentile_cont(0.05) within group (order by extract('epoch' from duration)) AS p05_duration,
    percentile_cont(0.25) within group (order by extract('epoch' from duration)) AS q1_duration,
    percentile_cont(0.50) within group (order by extract('epoch' from duration)) AS median_duration,
    percentile_cont(0.75) within group (order by extract('epoch' from duration)) AS q3_duration,
    percentile_cont(0.95) within group (order by extract('epoch' from duration)) AS p95_duration,
    percentile_cont(0.75) within group (order by extract('epoch' from duration)) -
    percentile_cont(0.25) within group (order by extract('epoch' from duration)) AS iqr_duration
  FROM disturbance_stops
  WHERE service_key = 'W'
  GROUP BY year, month, line_id, pattern_direction, start_quarter_hour
  ORDER BY year, month, line_id, pattern_direction, start_quarter_hour
;
