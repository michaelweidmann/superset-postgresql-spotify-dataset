#!/bin/bash

docker-compose down

docker volume rm postgres-data
docker volume rm superset-data