ALTER SYSTEM SET shared_buffers = 8017MB;
ALTER SYSTEM SET work_mem = 2GB;
ALTER SYSTEM SET maintenance_work_mem = 2GB;
ALTER SYSTEM SET max_wal_size = 10GB;
ALTER SYSTEM SET effective_cache_size = 30706MB;
ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements,auto_explain';
