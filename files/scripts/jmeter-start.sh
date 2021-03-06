#!/bin/bash

set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"
jmeter_args=$@

echo "START Running Jmeter Client on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=${jmeter_args}"

# Check jmeter automatic args for the output
jmeter_args=$(get-automatic-args.sh ${jmeter_args})
echo "jmeter automatic args=${jmeter_args}"

#Check for distributed settings
remote_args=""
if [[ ! -z ${JMETER_REMOTE_SERVERS} ]]; then 
    ssl_disable=TRUE
    if [[ ${JMETER_SSL_ENABLED^^} == "TRUE" ]]; then ssl_disable=FALSE; fi
    if [[ ${JMETER_CLOSE_REMOTE_SERVERS^^} == "TRUE" ]]; then remote_args="-X"; fi  
    remote_args="${remote_args} -Jclient.rmi.localport=${JMETER_CLIENT_PORT} -Jserver.rmi.ssl.disable=${ssl_disable} -R ${JMETER_REMOTE_SERVERS}"
    if [[ ! -z ${JMETER_SERVER_HOSTNAME} ]]; then remote_args="${remote_args} -Djava.rmi.server.hostname=${JMETER_SERVER_HOSTNAME}"; fi 
    echo "remote args=${remote_args}"
fi

# Keep entrypoint simple: we must pass the standard JMeter arguments
jmeter -n ${remote_args} ${jmeter_args}

# Check to generate outputs and upload data to object storage
process-outputs.sh

echo "END Running Jmeter on `date`"