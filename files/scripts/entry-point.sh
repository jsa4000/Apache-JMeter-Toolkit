#!/bin/bash

# Check for git source    
check-source.sh                                           

# Check for Jmeter Servers enabled  
echo "Jmeter Server enabled "${JMETER_SERVER_ENABLED^^}                        
if [[ ${JMETER_SERVER_ENABLED^^} == "TRUE" ]]; then     
	jmeter-server-start.sh $@
else
	jmeter-start.sh $@
fi                                               


