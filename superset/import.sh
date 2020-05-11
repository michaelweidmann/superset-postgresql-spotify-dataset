#!/bin/bash

# Create an admin account
superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin
# Prepare the metadata database for productive using
superset db upgrade
superset init
