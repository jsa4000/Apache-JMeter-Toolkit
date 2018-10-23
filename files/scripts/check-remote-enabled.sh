#!/bin/bash

#Check for remote configuration settings
if [[ ${JMETER_REMOTE_SERVERS^^} != "NONE" ]]; then 
    # Create new environment variable to use with JMeter parameters Globally.
    export JPTYPE="G"
else
    # Create new environment variable to use with JMeter parameters Locally
    export JPTYPE="J"
fi