DROP TABLE IF EXISTS census_tract_boundaries;
CREATE TABLE census_tract_boundaries AS
  SELECT geoid, wkb_geometry AS geom_multpoly_4326
  FROM census_gis.tl_2019_41_tract
  WHERE geoid LIKE '41005%' -- Clackamas
  OR geoid LIKE '41009%' -- Columbia
  OR geoid LIKE '41051%' -- Multnomah
  OR geoid LIKE '41067%' -- Washington
  OR geoid LIKE '41071%' -- Yamhill
UNION
  SELECT geoid, wkb_geometry AS geom_multpoly_4326
  FROM census_gis.tl_2019_53_tract
  WHERE geoid LIKE '53011%' -- Clark
  OR geoid LIKE '53059%' -- Skamania
UNION
  SELECT geoid, wkb_geometry AS geom_multpoly_4326
  FROM census_gis.tl_2019_11_tract
  WHERE geoid LIKE '11001%' -- Washington, DC
;
