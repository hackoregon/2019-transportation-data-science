\echo indexing
SET search_path TO :schema, public;
CREATE INDEX ON init_tripsh (opd_date);
CREATE INDEX ON init_tripsh (vehicle_id);
CREATE INDEX ON init_tripsh (event_no);
CREATE INDEX ON init_tripsh (line_id);
