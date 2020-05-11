@ECHO OFF

REM Timeout for safer starting of docker containers, because I experienced some issues.

REM Create the volumes for presistent data storage
docker volume create postgres-data
docker volume create superset-data
timeout /t 5 /nobreak > NUL

REM Create the superset and postgres container
docker-compose up -d
timeout /t 5 /nobreak > NUL

REM Setup postgres
CALL postgres\setup.bat
timeout /t 20 /nobreak > NUL

REM Setup superset
CALL superset\setup.bat
