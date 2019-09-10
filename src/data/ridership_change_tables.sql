DROP TABLE IF EXISTS riders_2010;
CREATE TEMPORARY TABLE riders_2010 AS
SELECT route_number, direction, location_id,
  sum(ons) AS ons_2010, sum(offs) AS offs_2010
FROM passenger_census
WHERE extract('year' FROM summary_begin_date) = 2010
GROUP BY route_number, direction, location_id;
DELETE FROM riders_2010 WHERE ons_2010 < 1 OR offs_2010 < 1;

DROP TABLE IF EXISTS riders_2017;
CREATE TEMPORARY TABLE riders_2017 AS
SELECT route_number, direction, location_id,
  sum(ons) AS ons_2017, sum(offs) AS offs_2017
FROM passenger_census
WHERE extract('year' FROM summary_begin_date) = 2017
GROUP BY route_number, direction, location_id;
DELETE FROM riders_2017 WHERE ons_2017 < 1 OR offs_2017 < 1;

DROP TABLE IF EXISTS ridership_deltas;
CREATE TABLE ridership_deltas AS
SELECT riders_2017.route_number, riders_2017.direction, riders_2017.location_id,
  ons_2010, ons_2017, ons_2017 - ons_2010 AS delta_ons,
  100.0 * (ons_2017::double precision / ons_2010::double precision - 1.0) AS pct_chg_ons,
  offs_2010, offs_2017, offs_2017 - offs_2010 AS delta_offs,
  100.0 * (offs_2017::double precision / offs_2010::double precision - 1.0) AS pct_chg_offs
FROM riders_2017 INNER JOIN riders_2010 
ON riders_2010.route_number = riders_2017.route_number
AND riders_2010.direction = riders_2017.direction
AND riders_2010.location_id = riders_2017.location_id;
