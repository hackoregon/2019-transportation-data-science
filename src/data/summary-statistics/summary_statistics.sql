DROP TABLE IF EXISTS bus_passenger_stops_summary;
CREATE TABLE bus_passenger_stops_summary AS
  SELECT extract('year' from service_date) AS year,
    extract('month' from service_date) AS month,
    arrive_quarter_hour, count(seconds_late) as samples,
    percentile_cont(0.5) within group (order by seconds_late) AS median_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) -
    percentile_cont(0.25) within group (order by seconds_late) AS iqr_seconds_late,
    sum(ons) AS system_total_ons, sum(offs) AS system_total_offs
  FROM bus_passenger_stops
  WHERE service_key = 'W'
  GROUP BY year, month, arrive_quarter_hour
  ORDER BY year, month, arrive_quarter_hour
;
COPY bus_passenger_stops_summary TO '/Work/bus_passenger_stops_summary.csv' WITH CSV HEADER;

DROP TABLE IF EXISTS rail_passenger_stops_summary;
CREATE TABLE rail_passenger_stops_summary AS
  SELECT extract('year' from service_date) AS year,
    extract('month' from service_date) AS month,
    arrive_quarter_hour, count(seconds_late) as samples,
    percentile_cont(0.5) within group (order by seconds_late) AS median_seconds_late,
    percentile_cont(0.75) within group (order by seconds_late) -
    percentile_cont(0.25) within group (order by seconds_late) AS iqr_seconds_late,
    sum(ons) AS system_total_ons, sum(offs) AS system_total_offs
  FROM rail_passenger_stops
  WHERE service_key = 'A'
  GROUP BY year, month, arrive_quarter_hour
  ORDER BY year, month, arrive_quarter_hour
;
COPY rail_passenger_stops_summary TO '/Work/rail_passenger_stops_summary.csv' WITH CSV HEADER;

DROP TABLE IF EXISTS disturbance_stops_summary;
CREATE TABLE disturbance_stops_summary AS
  SELECT year, month, start_quarter_hour, count(duration) as samples,
    percentile_cont(0.5) within group (order by extract('epoch' from duration)) AS median_duration,
    percentile_cont(0.75) within group (order by extract('epoch' from duration)) -
    percentile_cont(0.25) within group (order by extract('epoch' from duration)) AS iqr_duration
  FROM disturbance_stops
  WHERE service_key = 'W'
  GROUP BY year, month, start_quarter_hour
  ORDER BY year, month, start_quarter_hour
;
COPY disturbance_stops_summary TO '/Work/disturbance_stops_summary.csv' WITH CSV HEADER;
