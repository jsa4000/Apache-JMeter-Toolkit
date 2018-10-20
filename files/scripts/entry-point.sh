#!/bin/bash

# Check for git source    
check-source.sh                                           

# Check for Jmeter Servers enabled  
echo "Jmeter Server enabled "${JMETER_SERVER_ENABLED^^}                        
if [[ ${JMETER_SERVER_ENABLED^^} == "TRUE" ]]; then     
	# Start JMeter Server
	jmeter-server-start.sh $@
else
	# Check for Jmeter script enabled  
	echo "Jmeter Client script enabled "${JMETER_SCRIPT_MODE^^}
	if [[ ${JMETER_SCRIPT_MODE^^} == "TRUE" ]]; then 
		if [[ $@ != "" ]]; then
			command=($@)
			# Grant permissions on the script file (first argument)
			if [[ ${command[0]} != "bash" ]]; then chmod +x ${command[0]}; fi
			# Execute the command via bash
			$@
		fi
	else
		# Start JMeter client using the parameters
		jmeter-start.sh $@ 
	fi
fi                                               


