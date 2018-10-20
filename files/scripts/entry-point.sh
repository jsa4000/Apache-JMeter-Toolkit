#!/bin/bash

# Check for git source    
check-source.sh                                           

# Check for Jmeter Servers enabled  
echo "Jmeter Server enabled "${JMETER_SERVER_ENABLED^^}                        
if [[ ${JMETER_SERVER_ENABLED^^} == "TRUE" ]]; then     
	jmeter-server-start.sh $@
else
	echo "Jmeter Client script enabled "${JMETER_SCRIPT_MODE^^}
	if [[ ${JMETER_SCRIPT_MODE^^} == "TRUE" ]]; then 
		chmod +x $@ 
		$@
	else
		jmeter-start.sh $@ 
	fi
fi                                               


