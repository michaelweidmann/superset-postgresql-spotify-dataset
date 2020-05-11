#!/bin/bash

# Some sleep for safer starting of docker containers, because I experienced some issues.

# Create the volumes for presistent data storage
docker volume create postgres-data
docker volume create superset-data
sleep 5

# Create the superset and postgres container
docker-compose up -d
sleep 5

# Setup postgres
/bin/bash postgres/setup.sh
sleep 20

# Setup superset
/bin/bash superset/setup.sh
