#!/bin/bash

# Stop the containers
docker-compose down

# Remove the data
docker volume rm postgres-data
docker volume rm superset-data
