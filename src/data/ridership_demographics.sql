DROP TABLE IF EXISTS raw_ridership_demographics;
CREATE TEMPORARY TABLE raw_ridership_demographics AS
SELECT * FROM ridership_deltas AS d
INNER JOIN busstop_catchment_zone_with_census_attribs AS b
ON b.rte = d.route_number
AND b.dir = d.direction
AND b.stop_id = d.location_id
;

DROP TABLE IF EXISTS ridership_demographics;
CREATE TABLE ridership_demographics AS
SELECT route_number, direction, location_id,
  rte_desc, dir_desc, type, stop_name, 
  ons_2010, ons_2017, delta_ons, pct_chg_ons,
  offs_2010, offs_2017, delta_offs, pct_chg_offs, gentr_stage_group,
  medinc_10, medinc_17, medinc_17 - medinc_10 AS delta_medinc,
  100.0 * (medinc_17 / medinc_10 - 1.0) AS pct_chg_medinc,
  medrentval_10, medrentval_17, medrentval_17 - medrentval_10 AS delta_medrentval,
  100.0 * (medrentval_17 / medrentval_10 - 1.0) AS pct_chg_medrentval,
  povrate_10, povrate_17, povrate_17 - povrate_10 AS delta_povrate,
  100.0 * (povrate_17 / povrate_10 - 1.0) AS pct_chg_povrate,
  wkb_geometry
FROM raw_ridership_demographics
;
ALTER TABLE ridership_demographics ADD COLUMN id serial;
ALTER TABLE ridership_demographics ADD PRIMARY KEY (id);
