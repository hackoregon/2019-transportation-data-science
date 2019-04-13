\echo removing raw data
DROP TABLE IF EXISTS trimet_stop_event CASCADE;
DROP TABLE IF EXISTS init_tripsh CASCADE;
DROP TABLE IF EXISTS init_veh_stoph CASCADE;
\echo
\echo vacuuming
VACUUM ANALYZE;
