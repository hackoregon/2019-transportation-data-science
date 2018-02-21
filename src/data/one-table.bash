#! /bin/bash

# run the ddl
sed "s;ENDDATE;${tabledate};" ${tablename}.ddl | psql

# run the copy
export copy_command="\copy ${db_tablename} from '${interim}/${filename}' with csv header"
echo "${copy_command}"
/usr/bin/time psql -c "${copy_command}"

# run the post-processing
sed "s;ENDDATE;${tabledate};" ${tablename}.post | psql

# VACUUM ANALYZE
psql -c "VACUUM ANALYZE ${db_tablename};"

# dump the table
/usr/bin/time pg_dump --format=custom --no-owner --clean --if-exists --table=${db_tablename} \
  > ${interim}/${db_tablename}.backup
