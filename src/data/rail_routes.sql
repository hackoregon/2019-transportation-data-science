\echo creating rail route table
DROP TABLE IF EXISTS rail_routes;
CREATE TABLE rail_routes AS
SELECT DISTINCT rte FROM trimet_gis.tm_routes 
WHERE type = 'MAX'
ORDER BY rte;
