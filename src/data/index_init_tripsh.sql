\echo parsing dates
SET timezone = 'PST8PDT';
ALTER TABLE init_tripsh ADD COLUMN date_stamp timestamp with time zone;
UPDATE init_tripsh SET date_stamp = to_timestamp(opd_date, 'DDMONYYYY:HH24:MI:SS');
\echo
\echo deleting unwanted rows
DELETE FROM init_tripsh
  WHERE date_stamp NOT IN (SELECT date_stamp FROM weekdays)
  OR line_id IS NULL
  OR line_id > 291
  OR line_id < 1
;
\echo
\echo indexing
CREATE INDEX ON init_tripsh (date_stamp);
CREATE INDEX ON init_tripsh (vehicle_id);
CREATE INDEX ON init_tripsh (event_no);
CREATE INDEX ON init_tripsh (line_id);
\echo
\echo primary key
ALTER TABLE init_tripsh ADD COLUMN pkey serial;
ALTER TABLE init_tripsh ADD PRIMARY KEY (pkey);
