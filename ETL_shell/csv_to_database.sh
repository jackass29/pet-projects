#! /bin/bash

#----------------------------------------------------------------------------------------------------------------------------------------
# EXTRACT
#----------------------------------------------------------------------------------------------------------------------------------------
# Extract the columns 1 (user name), 2 (user id) and 6 (home dir path)
# from `/etc/passwd` file and write it to `extracted-data.log`
cut -d ":" -f 1,3,6 /etc/passwd > extracted-data.log

#----------------------------------------------------------------------------------------------------------------------------------------
# TRANSFORM
#----------------------------------------------------------------------------------------------------------------------------------------
# The extracted columns are separated by the original `:` delimiter
# We need to convert this into a `,` delimited file
# Read the extracted data from `extracted-data.log` and replace the colons with commas
# and save the results to `transformed-data.csv`
tr ":" "," < extracted-data.log > transformed-data.csv

#----------------------------------------------------------------------------------------------------------------------------------------
# LOAD
#----------------------------------------------------------------------------------------------------------------------------------------
echo "\c *db-name*; \COPY *table-name* FROM '*script-path*' DELIMITERS ',' [HEADERS] CSV;" | psql --username=*username* --host=*hostname*

#----------------------------------------------------------------------------------------------------------------------------------------
# OPTIONAL
#----------------------------------------------------------------------------------------------------------------------------------------
# Checking results
echo '\c *db-name*; \\SELECT * FROM *table-name*;' | psql --username=*username* --host=*hostname*

# To use this script you need to configure *db-name*, *table-name*, *script-path*, *username* and *hostname*
