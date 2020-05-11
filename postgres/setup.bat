@ECHO OFF

set container_name=spotify-data

REM Copy everything in the postgres container
docker cp "%~dp0artist.csv" %container_name%:/
docker cp "%~dp0ranking.csv" %container_name%:/
docker cp "%~dp0track.csv" %container_name%:/
docker cp "%~dp0import.sql" %container_name%:/
docker cp "%~dp0import.sh" %container_name%:/

REM Execute the import script
docker exec -it %container_name% "/import.sh"
