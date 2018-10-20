#!/bin/bash

set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "START Running Jmeter Client on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"

remote_args=""
#Check for distributed settings
if [[ ${JMETER_REMOTE_SERVERS^^} != "NONE" ]]; then 
    if [[ ${JMETER_CLOSE_REMOTE_SERVERS^^} == "TRUE" ]]; then 
        remote_args="-X"
    fi  
    remote_args="${remote_args} -Jclient.rmi.localport=${JMETER_CLIENT_PORT} -Jserver.rmi.ssl.disable=${JMETER_RMI_SSL_DISABLED} -R ${JMETER_REMOTE_SERVERS}"
    echo "remote args=${remote_args}"
fi  

# Keep entrypoint simple: we must pass the standard JMeter arguments
jmeter -n ${remote_args} $@

echo "END Running Jmeter on `date`"