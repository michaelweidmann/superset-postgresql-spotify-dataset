#!/bin/bash

# Some sleep for safer starting of docker containers, because I experienced some issues.

docker volume create postgres-data
docker volume create superset-data
sleep 5

docker-compose up -d
sleep 5

/bin/bash postgres/setup.sh
sleep 20

/bin/bash superset/setup.sh
