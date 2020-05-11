#!/bin/bash

# Create an admin account
superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin
# Prepare the metadata database for productive using
superset db upgrade
superset init

# Import the dashboards and the datasources
superset import-datasources -p /datasources.yaml
superset set_database_uri -d "Spotify Data" -u postgresql+psycopg2://postgres:postgres@spotify-data:5432/spotify
superset import-dashboards -p /dashboards.json
