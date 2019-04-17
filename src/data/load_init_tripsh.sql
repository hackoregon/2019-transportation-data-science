\echo loading :csvfile
COPY init_tripsh FROM :csvfile WITH csv header;
