
# dump db structure and all data, except for reference and region, where we only dump the 
# table structure; those can be filled with MGX-admin from the utilities repo

pg_dump --exclude-table-data=reference --exclude-table-data=region -d MGX2_global -h postgresql-15.intra -U gpmsroot -f MGX2_global.sql
