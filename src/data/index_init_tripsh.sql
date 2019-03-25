\echo deleting unwanted rows
SET search_path TO :schema, public;
DELETE FROM init_tripsh
  WHERE opd_date NOT IN (SELECT service_date FROM weekdays)
  OR line_id IS NULL
  OR line_id > 291
  OR line_id < 1
;
\echo indexing
CREATE INDEX ON init_tripsh (opd_date);
CREATE INDEX ON init_tripsh (vehicle_id);
CREATE INDEX ON init_tripsh (event_no);
CREATE INDEX ON init_tripsh (line_id);

\echo primary key
ALTER TABLE init_tripsh ADD COLUMN pkey serial;
ALTER TABLE init_tripsh ADD PRIMARY KEY (pkey);
