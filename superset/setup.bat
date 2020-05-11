@ECHO OFF

set container_name=superset

REM Copy everything in the superset container
docker cp "%~dp0import.sh" %container_name%:/

REM Execute the import script
docker exec -it %container_name% "/import.sh"
