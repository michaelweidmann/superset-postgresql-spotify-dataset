#!/bin/bash

# Execute all SQL statements int the import.sql file in the spotify database
psql -U postgres -a -f /import.sql -d spotify
# Remove unnecessary CSV files and the SQL import script
rm -rf /artist.csv /ranking.csv /track.csv /import.sql
