\echo making a usable date stamp
SET search_path TO init_veh_stoph, public;
ALTER TABLE :init_tripsh ADD COLUMN date_stamp date;
UPDATE :init_tripsh SET date_stamp = to_date(opd_date, 'DDMONYY');
ALTER TABLE :init_tripsh DROP COLUMN IF EXISTS opd_date;

\echo indexing the variables that define events
CREATE INDEX ON :init_tripsh (date_stamp);
