#!/bin/bash

set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"
jmeter_args=$@

echo "START Running Jmeter Server on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=${jmeter_args}"

# Check jmeter automatic args for the output
jmeter_args=$(get-automatic-args.sh ${jmeter_args})
echo "jmeter automatic args=${jmeter_args}"

#Set remote args
jmeter_remote_args="-Jclient.rmi.localport=${JMETER_CLIENT_PORT} -Jserver.rmi.ssl.disable=${JMETER_RMI_SSL_DISABLED} -Jserver.rmi.localport=${JMETER_SERVER_PORT}"
if [[ ! -z ${JMETER_SERVER_HOSTNAME} ]]; then jmeter_remote_args="${jmeter_remote_args} -Djava.rmi.server.hostname=${JMETER_SERVER_HOSTNAME}"; fi  
echo "jmeter remote args=${jmeter_remote_args}"

# Keep entrypoint simple: we must pass the standard JMeter arguments
jmeter -s -n ${jmeter_remote_args} ${jmeter_args}

echo "END Running Jmeter on `date`"