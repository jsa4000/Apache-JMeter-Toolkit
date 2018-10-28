#!/bin/bash

# Set Default Values
test_type=load # stress, load
remote_enabled=FALSE # true or false

# Get the arguments passed throug command line
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -t|--type)
        test_type="$2"
        shift # past argument
        shift # past value
        ;;
        -r|--remote)
        remote_enabled="$2"
        shift # past argument
        shift # past value
        ;;
    esac
done

# Print current values
echo TEST_TYPE          = "${test_type}"
echo REMOTE_ENABLED     = "${remote_enabled}"

# export current TEST_TYPE variable
export TEST_TYPE=${test_type};

# Run the docker compose with the proper test type
if [[ ${remote_enabled^^} == "FALSE" ]]; then 
    # Run the standalone testing
    docker-compose -f docker/docker-compose.yml up
else
    # Run the distributed testing
    docker-compose -f docker/docker-compose.distributed.yml up
fi



