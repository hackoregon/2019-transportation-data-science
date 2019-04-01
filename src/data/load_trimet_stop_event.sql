\echo loading :csvfile
COPY trimet_stop_event FROM :csvfile WITH csv header;
