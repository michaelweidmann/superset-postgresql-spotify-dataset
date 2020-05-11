#!/bin/bash

set container_name=superset

# Copy everything in the superset container
docker cp dashboards.json ${container_name}:/
docker cp datasources.yaml ${container_name}:/
docker cp import.sh ${container_name}:/

# Execute the import script
docker exec -it ${container_name} "/import.sh"
