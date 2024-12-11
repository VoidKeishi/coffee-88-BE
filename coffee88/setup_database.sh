#!/bin/bash

# Navigate to the SQL directory
cd sql

# Execute the SQL scripts
psql -U pseudo -d coffee88 -a -f reset.sql
psql -U pseudo -d coffee88 -a -f create.sql
psql -U pseudo -d coffee88 -a -f cafe.sql
psql -U pseudo -d coffee88 -a -f drink.sql