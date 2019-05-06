\echo removing raw data
DROP SCHEMA IF EXISTS old_raw CASCADE;
DROP SCHEMA IF EXISTS new_raw CASCADE;
\echo
\echo vacuuming
VACUUM VERBOSE ANALYZE;
