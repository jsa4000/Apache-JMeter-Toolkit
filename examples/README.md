# How to usei

## Start Tets

In order to start a test just use the following command

    bash start.sh

This script allows specific **arguments** to be passed through:

- **Testing Type**:
  - Argument: `-t`|`--type`
  - Values: `load`, `stress`, etc..
- **Remote Testing**: :
  - Argument: `-r`|`--remote`
  - Values: `true` or `false`

Following an example to run a **stress** test in a **distributed** way.

    bash start.sh -t stress -r true

> For distributed testing it is needed to run previously `docker-compose.servers.yml`

    docker-compose -f docker/docker-compose.servers.yml up
    docker-compose -f docker/docker-compose.servers.yml down

## Stop Test

To stop the test and the containers

    bash stop.sh