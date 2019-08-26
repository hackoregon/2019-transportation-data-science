DROP TABLE IF EXISTS metro_opportunity_zones;
CREATE TABLE metro_opportunity_zones AS
  SELECT * FROM "8764opportunityzones"
  WHERE geoid10 LIKE '41005%'
  OR geoid10 LIKE '41051%'
  OR geoid10 LIKE '41067%'
;
ALTER TABLE metro_opportunity_zones ADD PRIMARY KEY (geoid10);
