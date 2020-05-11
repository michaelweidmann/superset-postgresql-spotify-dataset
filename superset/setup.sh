#!/bin/bash

set container_name=superset

# Copy everything in the superset container
docker cp import.sh ${container_name}:/

# Execute the import script
docker exec -it ${container_name} "/import.sh"
