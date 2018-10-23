#!/bin/bash

# WARNING: DO NOT INTRODUCE ANY MORE "ECHO" IN-BETWEEN, SINCE THE OUTPUT WITH THE FINAL JMETER ARGS WILL BE RETURNED. 

# Check jmeter automatic args for the output
if [[ ${JMETER_AUTOMATIC_OUTPUT_ENABLED^^} == "TRUE" ]]; then 
    # Remove args [-l,--logfile,-j,--jmeterlogfile,-e,--reportatendofloadtests,-o,--reportoutputfolder]
    jmeter_args_array=($@)
    jmeter_clean_args=""
    expect_value=false
    for arg in "${jmeter_args_array[@]}"; do 
        if [[ ${expect_value} == true ]]; then continue; fi
        if [[ ${arg} == "-l" ]] || [[ ${arg} == "--logfile" ]] || [[ ${arg} == "-j" ]] || [[ ${arg} == "--jmeterlogfile" ]] || \
           [[ ${arg} == "-e" ]] || [[ ${arg} == "--reportatendofloadtests" ]] || [[ ${arg} == "-o" ]] || [[ ${arg} == "--reportoutputfolder" ]]; then 
            expect_value=true
        else
            expect_value=false
            jmeter_clean_args="${jmeter_clean_args} ${arg}"
        fi 
    done
    JMETER_ARGS="${jmeter_clean_args} -l ${JMETER_OUTPUT_PATH}/${JMETER_SUMMARY_FILENAME} -j ${JMETER_OUTPUT_PATH}/${JMETER_LOG_FILENAME}"
    JMETER_ARGS="${JMETER_ARGS} -o ${JMETER_OUTPUT_PATH}/${JMETER_DASHBOARD_PATHNAME} -e"
    echo ${JMETER_ARGS}
else
    echo $@
fi