#!/bin/bash

# Define some constants
summary_file_name="summary.csv"
log_file_name="logfile.log"
dashboard_folder_name="dashboard"
compressed_file_name="summary-outputs.tar.gz"

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

if [[ ${JMETER_AUTOMATIC_OUTPUT_ENABLED^^} == "TRUE" ]]; then 
    echo "Checking for duplicated outputs..."
    # Remove args [-l,--logfile,-j,--jmeterlogfile]
    jmeter_args_array=($jmeter_args)
    jmeter_clean_args=""
    expect_value=false
    for arg in "${jmeter_args_array[@]}"; do 
        if [[ ${expect_value} == true ]]; then continue; fi
        if [[ ${arg} == "-l" ]] || [[ ${arg} == "--logfile" ]] || [[ ${arg} == "-j" ]] || [[ ${arg} == "--jmeterlogfile" ]]; then 
            expect_value=true
        else
            expect_value=false
            jmeter_clean_args="${jmeter_clean_args} ${arg}"
        fi 
    done
    jmeter_args="${jmeter_clean_args} -l ${JMETER_OUTPUT_PATH}/${summary_file_name} -j ${JMETER_OUTPUT_PATH}/${log_file_name}"
    echo "jmeter automatic args=${jmeter_args}"
fi 

remote_args=""
#Check for distributed settings
if [[ ${JMETER_REMOTE_SERVERS^^} != "NONE" ]]; then 
    if [[ ${JMETER_CLOSE_REMOTE_SERVERS^^} == "TRUE" ]]; then remote_args="-X"; fi  
    remote_args="${remote_args} -Jclient.rmi.localport=${JMETER_CLIENT_PORT} -Jserver.rmi.ssl.disable=${JMETER_RMI_SSL_DISABLED} -R ${JMETER_REMOTE_SERVERS}"
    echo "remote args=${remote_args}"
fi

# Keep entrypoint simple: we must pass the standard JMeter arguments
jmeter -n ${remote_args} ${jmeter_args}

# Sleep 3 seconds to ensure jmeter has been shutdown properly
sleep 3

# Generate outputs and upload data to object storage
if [[ ${JMETER_AUTOMATIC_OUTPUT_ENABLED^^} == "TRUE" ]]; then 
    echo "Generating jmeter dashboard"
    jmeter -g ${JMETER_OUTPUT_PATH}/${summary_file_name} -o ${JMETER_OUTPUT_PATH}/${dashboard_folder_name}
    echo "Compressing output folder into a tar file"
    tar -zcf ${compressed_file_name} ${JMETER_OUTPUT_PATH}
    # Creating the prefix with the current time and the unixtime as unique indentifiers
    preffix="$(date +'%d%m%Y_%H%M%S')_$(($(date +'%s')))"
    mv ${compressed_file_name} ${JMETER_OUTPUT_PATH}/${preffix}_${compressed_file_name}
    echo "Uploading the content into the object storage"
    mc cp ${JMETER_OUTPUT_PATH}/${preffix}_${compressed_file_name} REPO/${MINIO_BUCKET_NAME}
fi

echo "END Running Jmeter on `date`"