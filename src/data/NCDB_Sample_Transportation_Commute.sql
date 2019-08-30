SET timezone = 'PST8PDT';
DROP TABLE IF EXISTS ncdb_sample_transportation_commute CASCADE;
CREATE TABLE ncdb_sample_transportation_commute (
  tract_geo_fips text,
  t128_001_17 integer,
  t128_002_17 integer,
  t128_009_17 integer,
  t128_010_17 integer,
  t128_003_17 integer,
  t128_004_17 integer,
  t128_005_17 integer,
  t128_006_17 integer,
  t128_007_17 integer,
  t128_008_17 integer,
  t129_001_17 integer,
  t129_002_17 integer,
  t129_003_17 integer,
  t129_004_17 integer,
  t129_005_17 integer,
  t129_006_17 integer,
  t129_007_17 integer,
  t129_008_17 integer,
  t129_009_17 integer,
  t129_010_17 integer,
  t147_001_17 integer,
  opp_zone boolean,
  opp_zone_elig text
);
\COPY ncdb_sample_transportation_commute FROM '/Raw/NCDB_Sample_Transportation_Commute.csv' WITH csv header

-- remove tracts not in Portland - Vancouver - Hillsboro CBSA
DELETE FROM ncdb_sample_transportation_commute
  WHERE tract_geo_fips NOT LIKE '41005%' -- Clackamas
  AND tract_geo_fips NOT LIKE '41009%' -- Columbia
  AND tract_geo_fips NOT LIKE '41051%' -- Multnomah
  AND tract_geo_fips NOT LIKE '41067%' -- Washington
  AND tract_geo_fips NOT LIKE '41071%' -- Yamhill
  AND tract_geo_fips NOT LIKE '53011%' -- Clark
  AND tract_geo_fips NOT LIKE '53059%' -- Skamania
  AND tract_geo_fips NOT LIKE '11001%' -- Washington, DC
;
ALTER TABLE ncdb_sample_transportation_commute ADD PRIMARY KEY (tract_geo_fips);

-- add boundary multipolygon
ALTER TABLE ncdb_sample_transportation_commute
ADD COLUMN IF NOT EXISTS geom_multpoly_4326 geometry(MULTIPOLYGON, 4326);
UPDATE ncdb_sample_transportation_commute
SET geom_multpoly_4326 = census_tract_boundaries.geom_multpoly_4326
FROM census_tract_boundaries
WHERE census_tract_boundaries.geoid = ncdb_sample_transportation_commute.tract_geo_fips
;
