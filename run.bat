@ECHO OFF

REM Timeout for safer starting of docker containers, because I experienced some issues.

docker volume create postgres-data
docker volume create superset-data
timeout /t 5 /nobreak > NUL

docker-compose up -d
timeout /t 5 /nobreak > NUL

CALL postgres\setup.bat
timeout /t 20 /nobreak > NUL

CALL superset\setup.bat
