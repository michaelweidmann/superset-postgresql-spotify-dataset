@ECHO OFF

REM Stop the containers
docker-compose down

REM Remove the data
docker volume rm postgres-data
docker volume rm superset-data
