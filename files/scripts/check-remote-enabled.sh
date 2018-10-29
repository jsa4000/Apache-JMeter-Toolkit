#!/bin/bash

#Check for remote configuration settings
if [[ ! -z ${JMETER_REMOTE_SERVERS} ]]; then 
    # Create new environment variable to use with JMeter parameters Globally.
    export JMETER_PARAM_TYPE="G"
else
    # Create new environment variable to use with JMeter parameters Locally
    export JMETER_PARAM_TYPE="J"
fi