DROP TABLE IF EXISTS bus_passenger_by_stop_summary;
CREATE TABLE bus_passenger_by_stop_summary AS
  SELECT extract('year' from service_date) AS year,
    extract('month' from service_date) AS month,
    arrive_quarter_hour, count(seconds_late) as samples,
    percentile_cont(0.05) within group (order by seconds_late) AS p05_seconds_late,
    percentile_cont(0.5) within group (order by seconds_late) AS median_seconds_late,
    percentile_cont(0.95) within group (order by seconds_late) AS p95_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) -
    percentile_cont(0.25) within group (order by seconds_late) AS iqr_seconds_late,
    percentile_cont(0.05) within group (order by ons) AS p05_ons,
    percentile_cont(0.5) within group (order by ons) AS median_ons,
    percentile_cont(0.95) within group (order by ons) AS p95_ons,
    percentile_cont(0.75) within group (order by ons) -
    percentile_cont(0.25) within group (order by ons) AS iqr_ons,
    percentile_cont(0.05) within group (order by offs) AS p05_offs,
    percentile_cont(0.5) within group (order by offs) AS median_offs,
    percentile_cont(0.95) within group (order by offs) AS p95_offs,
    percentile_cont(0.75) within group (order by offs) -
    percentile_cont(0.25) within group (order by offs) AS iqr_offs,
    sum(ons) AS system_total_ons, sum(offs) AS system_total_offs
  FROM bus_passenger_stops
  WHERE service_key = 'W'
  GROUP BY year, month, arrive_quarter_hour
  ORDER BY year, month, arrive_quarter_hour
;

DROP TABLE IF EXISTS rail_passenger_by_stop_summary;
CREATE TABLE rail_passenger_by_stop_summary AS
  SELECT extract('year' from service_date) AS year,
    extract('month' from service_date) AS month,
    arrive_quarter_hour, count(seconds_late) as samples,
    percentile_cont(0.05) within group (order by seconds_late) AS p05_seconds_late,
    percentile_cont(0.5) within group (order by seconds_late) AS median_seconds_late,
    percentile_cont(0.95) within group (order by seconds_late) AS p95_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) -
    percentile_cont(0.25) within group (order by seconds_late) AS iqr_seconds_late,
    percentile_cont(0.05) within group (order by ons) AS p05_ons,
    percentile_cont(0.5) within group (order by ons) AS median_ons,
    percentile_cont(0.95) within group (order by ons) AS p95_ons,
    percentile_cont(0.75) within group (order by ons) -
    percentile_cont(0.25) within group (order by ons) AS iqr_ons,
    percentile_cont(0.05) within group (order by offs) AS p05_offs,
    percentile_cont(0.5) within group (order by offs) AS median_offs,
    percentile_cont(0.95) within group (order by offs) AS p95_offs,
    percentile_cont(0.75) within group (order by offs) -
    percentile_cont(0.25) within group (order by offs) AS iqr_offs,
    sum(ons) AS system_total_ons, sum(offs) AS system_total_offs
  FROM rail_passenger_stops
  WHERE service_key = 'A'
  GROUP BY year, month, arrive_quarter_hour
  ORDER BY year, month, arrive_quarter_hour
;

DROP TABLE IF EXISTS disturbance_by_stop_summary;
CREATE TABLE disturbanceby_stop__summary AS
  SELECT year, month, start_quarter_hour, count(duration) as samples,
    percentile_cont(0.05) within group (order by extract('epoch' from duration)) AS p05_duration,
    percentile_cont(0.5) within group (order by extract('epoch' from duration)) AS median_duration,
    percentile_cont(0.95) within group (order by extract('epoch' from duration)) AS p95_duration,
    percentile_cont(0.75) within group (order by extract('epoch' from duration)) -
    percentile_cont(0.25) within group (order by extract('epoch' from duration)) AS iqr_duration
  FROM disturbance_stops
  WHERE service_key = 'W'
  GROUP BY year, month, start_quarter_hour
  ORDER BY year, month, start_quarter_hour
;
