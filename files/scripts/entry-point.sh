#!/bin/bash

# Set default environment variables and default values
source export-env-variables.sh

# Check for git source    
check-source.sh     

# Check for Jmeter Servers enabled  
echo "Jmeter Server enabled "${JMETER_SERVER_ENABLED^^}                        
if [[ ${JMETER_SERVER_ENABLED^^} == "TRUE" ]]; then     
	# Start JMeter Server
	jmeter-server-start.sh $@
else
	# Check if remote servers are configured to set the JPTYPE env variable
	source check-remote-enabled.sh
	# Check for Jmeter script enabled  
	echo "Jmeter Client script enabled "${JMETER_SCRIPT_MODE^^}
	if [[ ${JMETER_SCRIPT_MODE^^} == "TRUE" ]]; then 
		if [[ $@ != "" ]]; then
			args=($@)
			# Grant permissions on the script file (first argument)
			if [[ ${args[0]} != "bash" ]]; then chmod +x ${args[0]}; fi
			# Execute the command via bash
			$@
		fi
	else
		# Start JMeter client using the parameters
		jmeter-start.sh $@
	fi
fi                                               


