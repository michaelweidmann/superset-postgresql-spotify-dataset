#!/bin/bash

container_name="spotify-data"

# Copy everything in the postgres container
docker cp artist.csv ${container_name}:/
docker cp ranking.csv ${container_name}:/
docker cp track.csv ${container_name}:/
docker cp import.sql ${container_name}:/
docker cp import.sh ${container_name}:/

# Execute the import script
docker exec -it ${container_name} "/import.sh"
