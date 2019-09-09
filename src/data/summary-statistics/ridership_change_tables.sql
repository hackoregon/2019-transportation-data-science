DROP TABLE IF EXISTS riders_2010;
CREATE TABLE riders_2010 AS
SELECT location_id, sum(ons) AS ons_2010, sum(offs) AS offs_2010
FROM passenger_census
WHERE extract('year' FROM summary_begin_date) = 2010
GROUP BY location_id
ORDER BY ons_2010 DESC;
DROP TABLE IF EXISTS riders_2017;
CREATE TABLE riders_2017 AS
SELECT location_id, sum(ons) AS ons_2017, sum(offs) AS offs_2017
FROM passenger_census
WHERE extract('year' FROM summary_begin_date) = 2017
GROUP BY location_id
ORDER BY ons_2017 DESC;
