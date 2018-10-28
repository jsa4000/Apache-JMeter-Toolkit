# Run the docker compose with the proper test type
docker-compose -f docker/docker-compose.yml down
docker-compose -f docker/docker-compose.distributed.yml down

